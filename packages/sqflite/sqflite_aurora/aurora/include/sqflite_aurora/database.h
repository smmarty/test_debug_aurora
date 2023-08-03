/**
 * SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef FLUTTER_PLUGIN_SQFLITE_DATABASE_H
#define FLUTTER_PLUGIN_SQFLITE_DATABASE_H

#include <flutter/encodable.h>
#include <flutter/method-call.h>

#include <sqflite_aurora/globals.h>
#include <sqflite_aurora/logger.h>
#include <sqflite_aurora/utils.h>

#include <functional>
#include <sqlite3.h>
#include <string>
#include <unordered_map>
#include <queue>

class PLUGIN_EXPORT Database final
{
public:
    enum TransactionID {
        None = -2,
        Force = -1,
    };

    struct Cursor
    {
        int64_t id;
        sqlite3_stmt *stmt;
        int64_t pageSize;
    };

    struct Operation
    {
        std::string method;
        std::string sql;
        Encodable::List arguments;
    };

public:
    Database(int id, const std::string &path, bool singleInstance, const Logger &logger);
    ~Database();

public:
    utils::error open();
    utils::error openReadOnly();
    utils::error close();
    utils::error execute(const std::string &sql, const Encodable::List &args);
    utils::error queryCursorNext(int cursorID, bool cancel, Encodable::Map &result);
    utils::error query(const std::string &sql, const Encodable::List &args, Encodable::Map &result);
    utils::error queryWithPageSize(const std::string &sql,
                                   const Encodable::List &args,
                                   int64_t pageSize,
                                   Encodable::Map &result);
    utils::error insert(const std::string &sql, const Encodable::List &args, int &insertID);
    utils::error update(const std::string &sql, const Encodable::List &args, int &updated);
    utils::error batch(const std::vector<Operation> &operations,
                       bool continueOnError,
                       Encodable::List &results);

    void enterInTransaction();
    void leaveTransaction();
    int currentTransactionID();

    typedef std::function<void()> SqlCommandCallback;
    void processSqlCommand(int transactionID, const SqlCommandCallback &callback);

public:
    bool isOpen() const;
    bool isSingleInstance() const;
    bool isInTransaction() const;
    bool isInMemory() const;
    bool isReadOnly() const;

    const std::string &path() const;
    int64_t id() const;
    Logger::Level logLevel() const;

private:
    std::string currentErrorMessage();
    utils::error createParentDir();
    utils::error bindStmtArgs(sqlite3_stmt *stmt, const Encodable::List &args);

    void closeCursor(const Cursor &cursor);
    utils::error resultFromCursor(const Cursor &cursor, Encodable::Map &result);

private:
    int64_t m_id;
    std::string m_path;
    bool m_isSingleInstance;
    bool m_isReadOnly;
    Logger m_logger;
    int m_transactionID;
    int m_currentTransactionID;
    std::queue<SqlCommandCallback> m_pendingSqlCallbacks;
    int64_t m_cursorID;
    std::unordered_map<int64_t, Cursor> m_cursors;
    sqlite3 *m_db;
};

#endif /* FLUTTER_PLUGIN_SQFLITE_DATABASE_H */
