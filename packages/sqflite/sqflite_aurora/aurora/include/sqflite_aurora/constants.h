/**
 * SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef FLUTTER_PLUGIN_SQFLITE_CONSTANTS_H
#define FLUTTER_PLUGIN_SQFLITE_CONSTANTS_H

#include <string>

const inline std::string METHOD_GET_PLATFORM_VERSION = "getPlatformVersion";
const inline std::string METHOD_GET_DATABASES_PATH = "getDatabasesPath";
const inline std::string METHOD_DEBUG = "debug";
const inline std::string METHOD_OPTIONS = "options";
const inline std::string METHOD_OPEN_DATABASE = "openDatabase";
const inline std::string METHOD_CLOSE_DATABASE = "closeDatabase";
const inline std::string METHOD_INSERT = "insert";
const inline std::string METHOD_EXECUTE = "execute";
const inline std::string METHOD_QUERY = "query";
const inline std::string METHOD_QUERY_CURSOR_NEXT = "queryCursorNext";
const inline std::string METHOD_UPDATE = "update";
const inline std::string METHOD_BATCH = "batch";
const inline std::string METHOD_DELETE_DATABASE = "deleteDatabase";
const inline std::string METHOD_DATABASE_EXISTS = "databaseExists";

const inline std::string ARG_ID = "id";
const inline std::string ARG_PATH = "path";
const inline std::string ARG_READ_ONLY = "readOnly";
const inline std::string ARG_SINGLE_INSTANCE = "singleInstance";
const inline std::string ARG_LOG_LEVEL = "logLevel";
const inline std::string ARG_TRANSACTION_ID = "transactionId";
const inline std::string ARG_IN_TRANSACTION = "inTransaction";
const inline std::string ARG_RECOVERED = "recovered";
const inline std::string ARG_RECOVERED_IN_TRANSACTION = "recoveredInTransaction";
const inline std::string ARG_SQL = "sql";
const inline std::string ARG_SQL_ARGUMENTS = "arguments";
const inline std::string ARG_NO_RESULT = "noResult";
const inline std::string ARG_CONTINUE_ON_ERROR = "continueOnError";
const inline std::string ARG_COLUMNS = "columns";
const inline std::string ARG_ROWS = "rows";
const inline std::string ARG_DATABASES = "databases";
const inline std::string ARG_COMMAND = "cmd";
const inline std::string ARG_OPERATIONS = "operations";
const inline std::string ARG_METHOD = "method";
const inline std::string ARG_RESULT = "result";
const inline std::string ARG_ERROR = "error";
const inline std::string ARG_ERROR_CODE = "code";
const inline std::string ARG_ERROR_MESSAGE = "message";
const inline std::string ARG_ERROR_DATA = "data";
const inline std::string ARG_CURSOR_PAGE_SIZE = "cursorPageSize";
const inline std::string ARG_CURSOR_ID = "cursorId";
const inline std::string ARG_CANCEL = "cancel";

const inline std::string ERROR_SQFLITE = "sqlite_error";
const inline std::string ERROR_OPEN = "open_failed";
const inline std::string ERROR_CLOSE = "close_failed";
const inline std::string ERROR_CLOSED = "database_closed";
const inline std::string ERROR_BAD_PARAM = "bad_param";
const inline std::string ERROR_BAD_ARGS = "bad_arguments";
const inline std::string ERROR_INTERNAL = "internal";

#endif /* FLUTTER_PLUGIN_SQFLITE_CONSTANTS_H */
