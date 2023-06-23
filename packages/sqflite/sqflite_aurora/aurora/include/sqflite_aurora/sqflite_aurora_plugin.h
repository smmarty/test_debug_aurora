/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
#ifndef FLUTTER_PLUGIN_SQFLITE_H
#define FLUTTER_PLUGIN_SQFLITE_H

#include <flutter/plugin-interface.h>

#include <sqflite_aurora/async_queue.h>
#include <sqflite_aurora/database.h>
#include <sqflite_aurora/globals.h>

#include <memory>
#include <mutex>
#include <unordered_map>

class PLUGIN_EXPORT SqfliteAuroraPlugin final : public PluginInterface
{
public:
    SqfliteAuroraPlugin();
    void RegisterWithRegistrar(PluginRegistrar &registrar) override;

private:
    void onMethodCall(const MethodCall &call);
    void onPlatformVersionCall(const MethodCall &call);
    void onOpenDatabaseCall(const MethodCall &call);
    void onCloseDatabaseCall(const MethodCall &call);
    void onDeleteDatabaseCall(const MethodCall &call);
    void onDatabaseExistsCall(const MethodCall &call);
    void onGetDatabasesPathCall(const MethodCall &call);
    void onOptionsCall(const MethodCall &call);
    void onDebugCall(const MethodCall &call);
    void onExecuteCall(const MethodCall &call);
    void onQueryCall(const MethodCall &call);
    void onQueryCursorNextCall(const MethodCall &call);
    void onUpdateCall(const MethodCall &call);
    void onInsertCall(const MethodCall &call);
    void onBatchCall(const MethodCall &call);

    std::shared_ptr<Database> databaseByPath(const std::string &path);
    std::shared_ptr<Database> databaseByID(int64_t id);

    void databaseRemove(std::shared_ptr<Database> db);
    void databaseAdd(std::shared_ptr<Database> db);

    void sendSuccess(const MethodCall &call, const Encodable &result = nullptr);
    void sendError(const MethodCall &call,
                   const std::string &error,
                   const std::string &message,
                   const std::string &desc = "",
                   const Encodable &details = nullptr);

    Encodable::Map makeOpenResult(int64_t dbID, bool recovered, bool recoveredInTransaction);

private:
    std::mutex m_mutex;
    std::unordered_map<std::string, std::shared_ptr<Database>> m_singleInstanceDatabases;
    std::unordered_map<int64_t, std::shared_ptr<Database>> m_databases;
    int64_t m_dbID = 0;
    Logger m_logger;
    bool m_queryAsMapList = false;
    AsyncQueue m_asyncQueue;
};

#endif /* FLUTTER_PLUGIN_SQFLITE_H */
