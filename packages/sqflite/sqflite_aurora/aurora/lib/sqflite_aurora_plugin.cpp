/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
#include <flutter/application.h>
#include <flutter/logger.h>

#include <sqflite_aurora/constants.h>
#include <sqflite_aurora/sqflite_aurora_plugin.h>

#include <filesystem>
#include <fstream>

namespace {

int64_t getTransactionID(const Encodable &args)
{
    if (!args.HasKey(ARG_TRANSACTION_ID))
        return static_cast<int64_t>(Database::TransactionID::None);

    if (args[ARG_TRANSACTION_ID].IsNull())
        return static_cast<int64_t>(Database::TransactionID::None);

    if (!args[ARG_TRANSACTION_ID].IsInt())
        return static_cast<int64_t>(Database::TransactionID::None);

    return args[ARG_TRANSACTION_ID].GetInt();
}

Encodable::List getSqlArguments(const Encodable &args)
{
    if (!args.HasKey(ARG_SQL_ARGUMENTS))
        return Encodable::List{};

    if (args[ARG_SQL_ARGUMENTS].IsNull())
        return Encodable::List{};

    if (!args[ARG_SQL_ARGUMENTS].IsList())
        return Encodable::List{};

    return args[ARG_SQL_ARGUMENTS].GetList();
}

} /* namespace */

SqfliteAuroraPlugin::SqfliteAuroraPlugin()
    : m_dbID(0)
    , m_logger(Logger::Level::None, "sqflite")
{}

void SqfliteAuroraPlugin::RegisterWithRegistrar(PluginRegistrar &registrar)
{
    registrar.RegisterMethodChannel("com.tekartik.sqflite",
                                    MethodCodecType::Standard,
                                    [this](const MethodCall &call) { onMethodCall(call); });
}

void SqfliteAuroraPlugin::onMethodCall(const MethodCall &call)
{
    const auto &method = call.GetMethod();

    if (method == METHOD_GET_PLATFORM_VERSION) {
        onPlatformVersionCall(call);
        return;
    }

    if (method == METHOD_OPEN_DATABASE) {
        onOpenDatabaseCall(call);
        return;
    }

    if (method == METHOD_CLOSE_DATABASE) {
        onCloseDatabaseCall(call);
        return;
    }

    if (method == METHOD_DELETE_DATABASE) {
        onDeleteDatabaseCall(call);
        return;
    }

    if (method == METHOD_DATABASE_EXISTS) {
        onDatabaseExistsCall(call);
        return;
    }

    if (method == METHOD_GET_DATABASES_PATH) {
        onGetDatabasesPathCall(call);
        return;
    }

    if (method == METHOD_OPTIONS) {
        onOptionsCall(call);
        return;
    }

    if (method == METHOD_DEBUG) {
        onDebugCall(call);
        return;
    }

    if (method == METHOD_EXECUTE) {
        onExecuteCall(call);
        return;
    }

    if (method == METHOD_QUERY) {
        onQueryCall(call);
        return;
    }

    if (method == METHOD_QUERY_CURSOR_NEXT) {
        onQueryCursorNextCall(call);
        return;
    }

    if (method == METHOD_UPDATE) {
        onUpdateCall(call);
        return;
    }

    if (method == METHOD_INSERT) {
        onInsertCall(call);
        return;
    }

    if (method == METHOD_BATCH) {
        onBatchCall(call);
        return;
    }

    sendSuccess(call);
}

void SqfliteAuroraPlugin::onPlatformVersionCall(const MethodCall &call)
{
    std::ifstream in("/etc/os-release");
    std::string line;

    while (in.is_open() && std::getline(in, line)) {
        if (line.rfind("VERSION_ID=") != 0)
            continue;

        sendSuccess(call, "Aurora " + line.substr(11));
        return;
    }

    sendSuccess(call, "Aurora");
}

void SqfliteAuroraPlugin::onOpenDatabaseCall(const MethodCall &call)
{
    const auto dbPath = call.GetArgument<Encodable::String>(ARG_PATH);
    const auto readOnly = call.GetArgument<Encodable::Boolean>(ARG_READ_ONLY, false);

    const auto inMemory = dbPath.empty() || dbPath == ":memory:";
    const auto isSingleInstance = call.GetArgument<Encodable::Boolean>(ARG_SINGLE_INSTANCE)
                                  && !inMemory;

    if (isSingleInstance) {
        const auto db = databaseByPath(dbPath);

        if (db) {
            if (db->isOpen()) {
                m_logger.verb() << "re-opened single instance database"
                                << (db->isInTransaction() ? "(in transaction) " : "") << db->id()
                                << " " << db->path() << std::endl;

                sendSuccess(call, makeOpenResult(db->id(), true, db->isInTransaction()));
                return;
            }

            m_logger.verb() << "single instance database " << db->path() << " not opened"
                            << std::endl;
        }
    }

    const auto db = std::make_shared<Database>(++m_dbID, dbPath, isSingleInstance, m_logger);

    m_asyncQueue.push([this, db, readOnly, call] {
        m_logger.sql() << "open database " + db->path() + " (ID=" << db->id() << ")" << std::endl;

        const auto error = readOnly ? db->openReadOnly() : db->open();
        if (error) {
            sendError(call, ERROR_OPEN, db->path(), error.message());
            return;
        }

        databaseAdd(db);
        sendSuccess(call, makeOpenResult(db->id(), false, false));
    });
}

void SqfliteAuroraPlugin::onCloseDatabaseCall(const MethodCall &call)
{
    const auto dbID = call.GetArgument<Encodable::Int>(ARG_ID);
    const auto db = databaseByID(dbID);

    m_asyncQueue.push([this, db, dbID, call] {
        if (!db) {
            sendError(call, ERROR_CLOSED, "database closed", "ID=" + std::to_string(dbID) + ")");
            return;
        }

        m_logger.sql() << "closing database with ID=" << db->id() << std::endl;

        const auto error = db->close();
        if (error) {
            sendError(call, ERROR_CLOSE, db->path(), error.message());
            return;
        }

        databaseRemove(db);
        sendSuccess(call);
    });
}

void SqfliteAuroraPlugin::onDeleteDatabaseCall(const MethodCall &call)
{
    const auto dbPath = call.GetArgument<Encodable::String>(ARG_PATH);
    const auto db = databaseByPath(dbPath);

    m_asyncQueue.push([this, db, dbPath, call] {
        if (db) {
            if (db->isOpen()) {
                m_logger.verb() << "close database " << db->path() << " (ID=" << db->id() << ")"
                                << std::endl;

                const auto error = db->close();
                if (error) {
                    sendError(call, ERROR_CLOSE, db->path(), error.message());
                    return;
                }
            }

            databaseRemove(db);
        }

        if (std::filesystem::exists(dbPath)) {
            m_logger.verb() << "delete not opened database " << dbPath << std::endl;
            std::filesystem::remove(dbPath);
        }

        sendSuccess(call);
    });
}

void SqfliteAuroraPlugin::onDatabaseExistsCall(const MethodCall &call)
{
    const auto dbPath = call.GetArgument<Encodable::String>(ARG_PATH);
    sendSuccess(call, std::filesystem::exists(dbPath));
}

void SqfliteAuroraPlugin::onGetDatabasesPathCall(const MethodCall &call)
{
    const auto home = std::getenv("HOME");

    if (home == nullptr) {
        sendError(call, ERROR_INTERNAL, "environment variable $HOME not found");
        return;
    }

    const auto [orgname, appname] = Application::GetID();
    const auto directory = std::filesystem::path(home) / ".local/share" / orgname / appname;

    sendSuccess(call, directory.generic_string());
}

void SqfliteAuroraPlugin::onOptionsCall(const MethodCall &call)
{
    const auto level = call.GetArgument<Encodable::Int>(ARG_LOG_LEVEL);
    m_logger.setLogLevel(static_cast<Logger::Level>(level));

    sendSuccess(call);
}

void SqfliteAuroraPlugin::onDebugCall(const MethodCall &call)
{
    const auto cmd = call.GetArgument<Encodable::String>(ARG_COMMAND);

    std::lock_guard<std::mutex> lock(m_mutex);
    Encodable::Map result;

    if (cmd == "get") {
        if (m_logger.logLevel() > Logger::Level::None)
            result.emplace(ARG_LOG_LEVEL, static_cast<Encodable::Int>(m_logger.logLevel()));

        if (!m_databases.empty()) {
            Encodable::Map databases;

            for (const auto &[id, db] : m_databases) {
                Encodable::Map info;

                info.emplace(ARG_PATH, db->path());
                info.emplace(ARG_SINGLE_INSTANCE, db->isSingleInstance());

                if (db->logLevel() > Logger::Level::None)
                    info.emplace(ARG_LOG_LEVEL, static_cast<Encodable::Int>(db->logLevel()));

                databases.emplace(std::to_string(id), info);
            }

            result.emplace(ARG_DATABASES, databases);
        }
    }

    sendSuccess(call, result);
}

void SqfliteAuroraPlugin::onExecuteCall(const MethodCall &call)
{
    const auto dbID = call.GetArgument<Encodable::Int>(ARG_ID);
    const auto sql = call.GetArgument<Encodable::String>(ARG_SQL);
    const auto inTransactionChange = call.GetArgument<Encodable::Boolean>(ARG_IN_TRANSACTION, false);

    const auto sqlArgs = getSqlArguments(call.GetArguments());
    const auto transactionID = getTransactionID(call.GetArguments());
    const auto enteringTransaction = inTransactionChange == true
                                     && transactionID == Database::TransactionID::None;

    const auto db = databaseByID(dbID);

    if (!db) {
        sendError(call, ERROR_CLOSED, "database closed", "ID=" + std::to_string(dbID) + ")");
        return;
    }

    m_asyncQueue.push([this,
                       db,
                       sql,
                       sqlArgs,
                       inTransactionChange,
                       enteringTransaction,
                       transactionID,
                       call] {
        db->processSqlCommand(transactionID, [this, db, sql, sqlArgs, inTransactionChange, enteringTransaction, call] {
            if (enteringTransaction)
                db->enterInTransaction();

            const auto error = db->execute(sql, sqlArgs);

            if (error) {
                db->leaveTransaction();
                sendError(call, ERROR_INTERNAL, error.message());
                return;
            }

            if (enteringTransaction) {
                sendSuccess(call, Encodable::Map{{ARG_TRANSACTION_ID, db->currentTransactionID()}});
                return;
            }

            if (inTransactionChange == false)
                db->leaveTransaction();

            sendSuccess(call);
        });
    });
}

void SqfliteAuroraPlugin::onQueryCall(const MethodCall &call)
{
    const auto dbID = call.GetArgument<Encodable::Int>(ARG_ID);
    const auto sql = call.GetArgument<Encodable::String>(ARG_SQL);
    const auto pageSize = call.GetArgument<Encodable::Int>(ARG_CURSOR_PAGE_SIZE, -1);

    const auto sqlArgs = getSqlArguments(call.GetArguments());
    const auto transactionID = getTransactionID(call.GetArguments());
    const auto db = databaseByID(dbID);

    if (!db) {
        sendError(call, ERROR_CLOSED, "database closed", "ID=" + std::to_string(dbID) + ")");
        return;
    }

    m_asyncQueue.push([this, db, sql, sqlArgs, transactionID, pageSize, call] {
        db->processSqlCommand(transactionID, [this, db, sql, sqlArgs, pageSize, call] {
            Encodable::Map result;
            utils::error error;

            if (pageSize <= 0)
                error = db->query(sql, sqlArgs, result);
            else
                error = db->queryWithPageSize(sql, sqlArgs, pageSize, result);

            if (error) {
                sendError(call, ERROR_INTERNAL, error.message());
                return;
            }

            sendSuccess(call, result);
        });
    });
}

void SqfliteAuroraPlugin::onQueryCursorNextCall(const MethodCall &call)
{
    const auto dbID = call.GetArgument<Encodable::Int>(ARG_ID);
    const auto cursorID = call.GetArgument<Encodable::Int>(ARG_CURSOR_ID);
    const auto closeCursor = call.GetArgument<Encodable::Boolean>(ARG_CANCEL, false);

    const auto transactionID = getTransactionID(call.GetArguments());
    const auto db = databaseByID(dbID);

    if (!db) {
        sendError(call, ERROR_CLOSED, "database closed", "ID=" + std::to_string(dbID) + ")");
        return;
    }

    m_asyncQueue.push([this, db, cursorID, closeCursor, transactionID, call] {
        db->processSqlCommand(transactionID, [this, db, cursorID, closeCursor, call] {
            Encodable::Map result;
            const auto error = db->queryCursorNext(cursorID, closeCursor, result);

            if (error) {
                sendError(call, ERROR_INTERNAL, error.message());
                return;
            }

            sendSuccess(call, result);
        });
    });
}

void SqfliteAuroraPlugin::onUpdateCall(const MethodCall &call)
{
    const auto dbID = call.GetArgument<Encodable::Int>(ARG_ID);
    const auto sql = call.GetArgument<Encodable::String>(ARG_SQL);

    const auto sqlArgs = getSqlArguments(call.GetArguments());
    const auto transactionID = getTransactionID(call.GetArguments());
    const auto db = databaseByID(dbID);

    if (!db) {
        sendError(call, ERROR_CLOSED, "database closed", "ID=" + std::to_string(dbID) + ")");
        return;
    }

    m_asyncQueue.push([this, db, sql, sqlArgs, transactionID, call] {
        db->processSqlCommand(transactionID, [this, db, sql, sqlArgs, call] {
            int updated = 0;
            const auto error = db->update(sql, sqlArgs, updated);

            if (error) {
                sendError(call, ERROR_INTERNAL, error.message());
                return;
            }

            sendSuccess(call, updated);
        });
    });
}

void SqfliteAuroraPlugin::onInsertCall(const MethodCall &call)
{
    const auto dbID = call.GetArgument<Encodable::Int>(ARG_ID);
    const auto sql = call.GetArgument<Encodable::String>(ARG_SQL);

    const auto sqlArgs = getSqlArguments(call.GetArguments());
    const auto transactionID = getTransactionID(call.GetArguments());
    const auto db = databaseByID(dbID);

    if (!db) {
        sendError(call, ERROR_CLOSED, "database closed", "ID=" + std::to_string(dbID) + ")");
        return;
    }

    m_asyncQueue.push([this, db, sql, sqlArgs, transactionID, call] {
        db->processSqlCommand(transactionID, [this, db, sql, sqlArgs, call] {
            int insertID = 0;
            const auto error = db->insert(sql, sqlArgs, insertID);

            if (error) {
                sendError(call, ERROR_INTERNAL, error.message());
                return;
            }

            if (insertID == 0)
                sendSuccess(call);
            else
                sendSuccess(call, insertID);
        });
    });
}

void SqfliteAuroraPlugin::onBatchCall(const MethodCall &call)
{
    const auto dbID = call.GetArgument<Encodable::Int>(ARG_ID);
    const auto &operations = call.GetArgument<Encodable::List>(ARG_OPERATIONS);
    const auto noResult = call.GetArgument<Encodable::Boolean>(ARG_NO_RESULT, false);
    const auto continueOnError = call.GetArgument<Encodable::Boolean>(ARG_CONTINUE_ON_ERROR, false);

    const auto transactionID = getTransactionID(call.GetArguments());
    const auto db = databaseByID(dbID);

    if (!db) {
        sendError(call, ERROR_CLOSED, "database closed", "ID=" + std::to_string(dbID) + ")");
        return;
    }

    std::vector<Database::Operation> dbOperations;

    for (const auto &operation : operations) {
        const auto method = operation[ARG_METHOD].GetString();
        const auto sql = operation[ARG_SQL].GetString();
        const auto sqlArgs = getSqlArguments(operation);

        dbOperations.emplace_back(Database::Operation{method, sql, sqlArgs});
    }

    m_asyncQueue.push([this, db, dbOperations, transactionID, continueOnError, noResult, call] {
        const auto command = [this, db, dbOperations, continueOnError, noResult, call] {
            Encodable::List results;
            const auto error = db->batch(dbOperations, continueOnError, results);
            if (error) {
                sendError(call, ERROR_INTERNAL, error.message());
                return;
            }

            if (noResult)
                sendSuccess(call);
            else
                sendSuccess(call, results);
        };

        db->processSqlCommand(transactionID, command);
    });
}

std::shared_ptr<Database> SqfliteAuroraPlugin::databaseByPath(const std::string &path)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    if (!m_singleInstanceDatabases.count(path))
        return nullptr;

    return m_singleInstanceDatabases.at(path);
}

std::shared_ptr<Database> SqfliteAuroraPlugin::databaseByID(int64_t id)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    if (!m_databases.count(id))
        return nullptr;

    return m_databases.at(id);
}

void SqfliteAuroraPlugin::databaseRemove(std::shared_ptr<Database> db)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    if (db->isSingleInstance())
        m_singleInstanceDatabases.erase(db->path());

    m_databases.erase(db->id());
}

void SqfliteAuroraPlugin::databaseAdd(std::shared_ptr<Database> db)
{
    std::lock_guard<std::mutex> lock(m_mutex);

    if (db->isSingleInstance())
        m_singleInstanceDatabases.emplace(db->path(), db);

    m_databases.emplace(db->id(), db);
}

void SqfliteAuroraPlugin::sendSuccess(const MethodCall &call, const Encodable &result)
{
    call.SendSuccessResponse(result);
}

void SqfliteAuroraPlugin::sendError(const MethodCall &call,
                                    const std::string &error,
                                    const std::string &message,
                                    const std::string &desc,
                                    const Encodable &details)
{
    call.SendErrorResponse(ERROR_SQFLITE,
                           error + ": " + message + (desc.empty() ? "" : " (" + desc + ")"),
                           details);
}

Encodable::Map SqfliteAuroraPlugin::makeOpenResult(int64_t dbID,
                                                   bool recovered,
                                                   bool recoveredInTransaction)
{
    Encodable::Map result = {{ARG_ID, dbID}};

    if (recovered)
        result.emplace(ARG_RECOVERED, true);

    if (recoveredInTransaction)
        result.emplace(ARG_RECOVERED_IN_TRANSACTION, true);

    return result;
}
