/**
 * SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
 * SPDX-License-Identifier: BSD-3-Clause
 */
#include <sqflite_aurora/constants.h>
#include <sqflite_aurora/database.h>

#include <filesystem>
#include <limits>

namespace {

void addError(Encodable::List &results, const utils::error &error)
{
    if (error) {
        results.emplace_back(Encodable::Map{
            {"error", Encodable::Map{{"message", error.message()}}},
        });
    }
}

template<typename T>
void addResult(Encodable::List &results, const T &result)
{
    results.emplace_back(Encodable::Map{{"result", result}});
}

} /* namespace */

Database::Database(int id, const std::string &path, bool singleInstance, const Logger &logger)
    : m_id(id)
    , m_path(path)
    , m_isSingleInstance(singleInstance)
    , m_logger(logger.logLevel(), logger.tag() + "-db-" + std::to_string(id))
    , m_transactionID(0)
    , m_currentTransactionID(TransactionID::None)
    , m_cursorID(0)
    , m_db(nullptr)
{}

Database::~Database()
{
    close();
}

utils::error Database::open()
{
    const auto error = createParentDir();
    if (error)
        return error;

    int result_code = sqlite3_open_v2(m_path.c_str(),
                                      &m_db,
                                      SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE,
                                      nullptr);
    if (result_code != SQLITE_OK)
        return utils::error(currentErrorMessage());

    m_isReadOnly = false;
    return utils::error::none();
}

utils::error Database::openReadOnly()
{
    const auto error = createParentDir();
    if (error)
        return error;

    int result_code = sqlite3_open_v2(m_path.c_str(), &m_db, SQLITE_OPEN_READONLY, nullptr);
    if (result_code != SQLITE_OK)
        return utils::error(currentErrorMessage());

    m_isReadOnly = true;
    return utils::error::none();
}

utils::error Database::close()
{
    if (sqlite3_close_v2(m_db) != SQLITE_OK)
        return utils::error(currentErrorMessage());

    m_db = nullptr;
    m_pendingSqlCallbacks = {};

    return utils::error::none();
}

utils::error Database::execute(const std::string &sql, const Encodable::List &args)
{
    sqlite3_stmt *stmt = nullptr;

    if (sqlite3_prepare_v2(m_db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        return utils::error(currentErrorMessage());

    const auto error = bindStmtArgs(stmt, args);

    if (error) {
        sqlite3_finalize(stmt);
        return error;
    }

    while (true) {
        int status = sqlite3_step(stmt);

        if (status == SQLITE_ROW)
            continue;

        if (status == SQLITE_DONE)
            break;

        sqlite3_finalize(stmt);
        return utils::error(currentErrorMessage());
    }

    sqlite3_finalize(stmt);
    return utils::error::none();
}

utils::error Database::query(const std::string &sql,
                                           const Encodable::List &args,
                                           Encodable::Map &result)
{
    sqlite3_stmt *stmt = nullptr;

    if (sqlite3_prepare_v2(m_db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        return utils::error(currentErrorMessage());

    const auto error = bindStmtArgs(stmt, args);

    if (error) {
        sqlite3_finalize(stmt);
        return error;
    }

    Encodable::List columns;

    for (int idx = 0; idx < sqlite3_column_count(stmt); idx++)
        columns.emplace_back(sqlite3_column_name(stmt, idx));

    Encodable::List rows;

    while (true) {
        int status = sqlite3_step(stmt);

        if (status == SQLITE_ROW) {
            Encodable::List row;

            for (size_t idx = 0; idx < columns.size(); idx++) {
                switch (sqlite3_column_type(stmt, idx)) {
                case SQLITE_INTEGER:
                    row.emplace_back(sqlite3_column_int64(stmt, idx));
                    break;
                case SQLITE_FLOAT:
                    row.emplace_back(sqlite3_column_double(stmt, idx));
                    break;
                case SQLITE_TEXT:
                    row.emplace_back(reinterpret_cast<const char *>(sqlite3_column_text(stmt, idx)));
                    break;
                case SQLITE_BLOB: {
                    const uint8_t *blob = reinterpret_cast<const uint8_t *>(
                        sqlite3_column_blob(stmt, idx));
                    std::vector<uint8_t> v(blob, blob + sqlite3_column_bytes(stmt, idx));
                    row.emplace_back(v);
                    break;
                }
                case SQLITE_NULL: {
                    const char *columnDecltype = sqlite3_column_decltype(stmt, idx);

                    if (columnDecltype != NULL && std::string("BLOB") == columnDecltype)
                        row.emplace_back(Encodable::Uint8List{});
                    else
                        row.emplace_back(nullptr);

                    break;
                }
                default:
                    break;
                }
            }

            rows.emplace_back(row);
            continue;
        }

        if (status == SQLITE_DONE)
            break;

        sqlite3_finalize(stmt);
        return utils::error(currentErrorMessage());
    }

    result = Encodable::Map{{"columns", columns}, {"rows", rows}};

    sqlite3_finalize(stmt);
    return utils::error::none();
}

utils::error Database::queryWithPageSize(const std::string &sql,
                                                       const Encodable::List &args,
                                                       int64_t pageSize,
                                                       Encodable::Map &result)
{
    sqlite3_stmt *stmt = nullptr;

    if (sqlite3_prepare_v2(m_db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
        return utils::error(currentErrorMessage());

    const auto error = bindStmtArgs(stmt, args);

    if (error)
        return error;

    m_cursorID += 1;
    m_cursors[m_cursorID] = Cursor{m_cursorID, stmt, pageSize};

    return resultFromCursor(m_cursors[m_cursorID], result);
}

utils::error Database::queryCursorNext(int cursorID,
                                                     bool cancel,
                                                     Encodable::Map &result)
{
    m_logger.verb() << "querying cursor next (ID=" << cursorID << "; CANCEL=" << cancel << ")"
                    << std::endl;

    if (!m_cursors.count(cursorID))
        return utils::error("cursor not found");

    const Cursor &cursor = m_cursors[cursorID];

    if (cancel) {
        closeCursor(cursor);
        return utils::error::none();
    }

    return resultFromCursor(cursor, result);
}

utils::error Database::insert(const std::string &sql,
                                            const Encodable::List &args,
                                            int &insertID)
{
    if (m_isReadOnly)
        return utils::error("database is readonly");

    const auto error = execute(sql, args);

    if (error)
        return error;

    const int updated = sqlite3_changes(m_db);

    m_logger.sql() << "rows updated: " << updated << std::endl;

    if (updated == 0) {
        insertID = 0;
        return utils::error::none();
    }

    insertID = sqlite3_last_insert_rowid(m_db);
    m_logger.sql() << "last inserted row id: " << insertID << std::endl;

    return utils::error::none();
}

utils::error Database::update(const std::string &sql,
                                            const Encodable::List &args,
                                            int &updated)
{
    if (m_isReadOnly)
        return utils::error("database is readonly");

    const auto error = execute(sql, args);

    if (error)
        return error;

    updated = sqlite3_changes(m_db);
    m_logger.sql() << "rows updated: " << updated << std::endl;

    return utils::error::none();
}

void Database::processSqlCommand(int transactionID, const SqlCommandCallback &callback)
{
    if (m_currentTransactionID == TransactionID::None) {
        callback();
        return;
    }

    if (transactionID == m_currentTransactionID || transactionID == TransactionID::Force) {
        callback();

        if (m_currentTransactionID == TransactionID::None) {
            while (!m_pendingSqlCallbacks.empty() && isOpen()) {
                const auto &pendingCallback = m_pendingSqlCallbacks.front();
                pendingCallback();
                m_pendingSqlCallbacks.pop();
            }
        }

        return;
    }

    m_pendingSqlCallbacks.push(callback);
}

void Database::enterInTransaction()
{
    m_transactionID += 1;
    m_currentTransactionID = m_transactionID;
}

void Database::leaveTransaction()
{
    m_currentTransactionID = TransactionID::None;
}

int Database::currentTransactionID()
{
    return m_currentTransactionID;
}

bool Database::isOpen() const
{
    return m_db != nullptr;
}

const std::string &Database::path() const
{
    return m_path;
}

bool Database::isSingleInstance() const
{
    return m_isSingleInstance;
}

bool Database::isReadOnly() const
{
    return m_isReadOnly;
}

bool Database::isInTransaction() const
{
    return m_currentTransactionID != TransactionID::None;
}

int64_t Database::id() const
{
    return m_id;
}

Logger::Level Database::logLevel() const
{
    return m_logger.logLevel();
}

bool Database::isInMemory() const
{
    return m_path.empty() || m_path == ":memory:";
}

std::string Database::currentErrorMessage()
{
    const auto message = sqlite3_errmsg(m_db);
    const auto code = sqlite3_extended_errcode(m_db);

    return std::string(message) + " (" + std::to_string(code) + ")";
}

utils::error Database::createParentDir()
{
    if (isInMemory())
        return utils::error::none();

    const auto parentDir = std::filesystem::path(m_path).parent_path();

    if (std::filesystem::exists(parentDir))
        return utils::error::none();

    if (std::filesystem::create_directories(parentDir))
        return utils::error::none();

    return utils::error("couldn't create parent directory");
}

utils::error Database::bindStmtArgs(sqlite3_stmt *stmt, const Encodable::List &args)
{
    int result = SQLITE_OK;

    for (size_t i = 0; i < args.size(); i++) {
        auto idx = i + 1;
        auto &arg = args[i];

        if (arg.IsNull()) {
            result = sqlite3_bind_null(stmt, idx);
        } else if (arg.IsBoolean()) {
            result = sqlite3_bind_int(stmt, idx, static_cast<int>(arg.GetBoolean()));
        } else if (arg.IsInt()) {
            const int64_t value = arg.GetInt();

            const int32_t i32min = std::numeric_limits<int32_t>::min();
            const int32_t i32max = std::numeric_limits<int32_t>::max();

            if (value < i32min || value > i32max)
                result = sqlite3_bind_int64(stmt, idx, arg.GetInt());
            else
                result = sqlite3_bind_int64(stmt, idx, static_cast<int32_t>(arg.GetInt()));
        } else if (arg.IsFloat()) {
            result = sqlite3_bind_double(stmt, idx, arg.GetFloat());
        } else if (arg.IsString()) {
            const auto &string = arg.GetString();
            result = sqlite3_bind_text(stmt, idx, string.c_str(), string.size(), SQLITE_TRANSIENT);
        } else if (arg.IsUint8List()) {
            const auto &container = arg.GetUint8List();
            result = sqlite3_bind_blob(stmt,
                                       idx,
                                       container.data(),
                                       container.size(),
                                       SQLITE_TRANSIENT);
        } else if (arg.IsInt32List()) {
            const auto &container = arg.GetInt32List();
            result = sqlite3_bind_blob(stmt,
                                       idx,
                                       container.data(),
                                       container.size() * sizeof(int32_t),
                                       SQLITE_TRANSIENT);
        } else if (arg.IsInt64List()) {
            const auto &container = arg.GetInt64List();
            result = sqlite3_bind_blob(stmt,
                                       idx,
                                       container.data(),
                                       container.size() * sizeof(int64_t),
                                       SQLITE_TRANSIENT);
        } else if (arg.IsFloat32List()) {
            const auto &container = arg.GetFloat32List();
            result = sqlite3_bind_blob(stmt,
                                       idx,
                                       container.data(),
                                       container.size() * sizeof(float),
                                       SQLITE_TRANSIENT);
        } else if (arg.IsFloat64List()) {
            const auto &container = arg.GetFloat64List();
            result = sqlite3_bind_blob(stmt,
                                       idx,
                                       container.data(),
                                       container.size() * sizeof(double),
                                       SQLITE_TRANSIENT);
        } else if (arg.IsList()) {
            /* only bytes list is supported */
            std::vector<uint8_t> container;

            for (const auto &entry : arg.GetList()) {
                if (!entry.IsInt())
                    return utils::error("only list of bytes is supported for statement parameter");

                const auto value = entry.GetInt();

                if (value < 0 || value > 255)
                    return utils::error("only list of bytes is supported for statement parameter");

                container.push_back(static_cast<uint8_t>(value));
            }

            result = sqlite3_bind_blob(stmt,
                                       idx,
                                       container.data(),
                                       container.size(),
                                       SQLITE_TRANSIENT);
        } else {
            return utils::error("statement parameter has invalid type");
        }

        if (result != SQLITE_OK)
            return utils::error(currentErrorMessage());
    }

    m_logger.sql() << sqlite3_expanded_sql(stmt) << std::endl;
    return utils::error::none();
}

void Database::closeCursor(const Cursor &cursor)
{
    m_logger.verb() << "closing cursor (ID=" << cursor.id << ")" << std::endl;
    sqlite3_finalize(cursor.stmt);
    m_cursors.erase(cursor.id);
}

utils::error Database::resultFromCursor(const Cursor &cursor, Encodable::Map &result)
{
    Encodable::List columns;

    for (int idx = 0; idx < sqlite3_column_count(cursor.stmt); idx++)
        columns.emplace_back(sqlite3_column_name(cursor.stmt, idx));

    Encodable::List rows;
    int status = SQLITE_ROW;

    while (static_cast<int64_t>(rows.size()) < cursor.pageSize) {
        status = sqlite3_step(cursor.stmt);

        if (status == SQLITE_ROW) {
            Encodable::List row;

            for (size_t idx = 0; idx < columns.size(); idx++) {
                switch (sqlite3_column_type(cursor.stmt, idx)) {
                case SQLITE_INTEGER:
                    row.emplace_back(sqlite3_column_int64(cursor.stmt, idx));
                    break;
                case SQLITE_FLOAT:
                    row.emplace_back(sqlite3_column_double(cursor.stmt, idx));
                    break;
                case SQLITE_TEXT:
                    row.emplace_back(
                        reinterpret_cast<const char *>(sqlite3_column_text(cursor.stmt, idx)));
                    break;
                case SQLITE_BLOB: {
                    const uint8_t *blob = reinterpret_cast<const uint8_t *>(
                        sqlite3_column_blob(cursor.stmt, idx));
                    std::vector<uint8_t> v(blob, blob + sqlite3_column_bytes(cursor.stmt, idx));
                    row.emplace_back(v);
                    break;
                }
                case SQLITE_NULL: {
                    const char *columnDecltype = sqlite3_column_decltype(cursor.stmt, idx);

                    if (columnDecltype != NULL && std::string("BLOB") == columnDecltype)
                        row.emplace_back(Encodable::Uint8List{});
                    else
                        row.emplace_back(nullptr);

                    break;
                }
                default:
                    break;
                }
            }

            rows.emplace_back(row);
            continue;
        }

        if (status == SQLITE_DONE) {
            closeCursor(cursor);
            break;
        }

        closeCursor(cursor);
        return utils::error(currentErrorMessage());
    }

    result = Encodable::Map{{"columns", columns}, {"rows", rows}};

    if (status != SQLITE_DONE)
        result.insert({ARG_CURSOR_ID, cursor.id});

    return utils::error::none();
}

utils::error Database::batch(const std::vector<Operation> &operations,
                                           bool continueOnError,
                                           Encodable::List &results)
{
    for (const auto &operation : operations) {
        const auto &method = operation.method;

        if (method == METHOD_INSERT) {
            int insertID = 0;
            const auto error = insert(operation.sql, operation.arguments, insertID);

            if (error) {
                if (!continueOnError)
                    return error;

                addError(results, error);
                continue;
            }

            if (insertID == 0)
                addResult(results, nullptr);
            else
                addResult(results, insertID);

            continue;
        }

        if (method == METHOD_EXECUTE) {
            const auto error = execute(operation.sql, operation.arguments);

            if (error) {
                if (!continueOnError)
                    return error;

                addError(results, error);
                continue;
            }

            addResult(results, nullptr);
            continue;
        }

        if (method == METHOD_QUERY) {
            Encodable::Map result;
            const auto error = query(operation.sql, operation.arguments, result);

            if (error) {
                if (!continueOnError)
                    return error;

                addError(results, error);
                continue;
            }

            addResult(results, result);
            continue;
        }

        if (method == METHOD_UPDATE) {
            int updated = 0;
            const auto error = update(operation.sql, operation.arguments, updated);

            if (error) {
                if (!continueOnError)
                    return error;

                addError(results, error);
                continue;
            }

            addResult(results, updated);
            continue;
        }
    }

    return utils::error::none();
}
