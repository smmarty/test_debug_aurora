/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
#include <sqflite_aurora/async_queue.h>

AsyncQueue::AsyncQueue()
    : m_running(false)
    , m_thread()
{}

AsyncQueue::~AsyncQueue()
{
    m_running = false;
    m_thread.join();
}

void AsyncQueue::push(const Task &task)
{
    if (!m_running) {
        m_running = true;
        m_tasks.push(task);
        m_thread = std::thread(&AsyncQueue::run, this);
        return;
    }

    std::lock_guard<std::mutex> lock(m_mutex);

    m_tasks.push(task);
    m_condition.notify_one();
}

void AsyncQueue::run()
{
    while (m_running) {
        std::unique_lock<std::mutex> lock(m_mutex);
        m_condition.wait(lock, [this] { return !m_tasks.empty(); });

        const auto task = m_tasks.front();
        m_tasks.pop();

        lock.unlock();
        task();
    }
}
