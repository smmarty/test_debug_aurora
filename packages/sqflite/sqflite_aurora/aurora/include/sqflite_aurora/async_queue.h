/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
#ifndef FLUTTER_PLUGIN_SQFLITE_ASYNC_QUEUE_H
#define FLUTTER_PLUGIN_SQFLITE_ASYNC_QUEUE_H

#include <condition_variable>
#include <functional>
#include <mutex>
#include <queue>
#include <thread>

#include <sqflite_aurora/globals.h>

class PLUGIN_EXPORT AsyncQueue final
{
public:
    typedef std::function<void()> Task;

public:
    AsyncQueue();
    ~AsyncQueue();

    void push(const Task &task);

private:
    void run();

private:
    bool m_running;
    std::thread m_thread;
    std::queue<Task> m_tasks;
    std::mutex m_mutex;
    std::condition_variable m_condition;
};

#endif /* FLUTTER_PLUGIN_SQFLITE_ASYNC_QUEUE_H */
