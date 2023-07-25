/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
#include <flutter/logger.h>
#include <sqflite_aurora/logger.h>

Logger::Logger(Level level, const std::string &tag)
    : m_level(level)
    , m_tag(tag)
    , m_devnull(0)
{}

Logger::Level Logger::logLevel() const
{
    return m_level;
}

void Logger::setLogLevel(Level level)
{
    m_level = level;
}

std::string Logger::tag() const
{
    return m_tag;
}

void Logger::setTag(const std::string &tag)
{
    m_tag = tag;
}

std::ostream &Logger::verb()
{
    if (m_level >= Level::Verbose)
        return loginfo << (m_tag.empty() ? "" : "[" + m_tag + "] ");

    return m_devnull;
}

std::ostream &Logger::sql()
{
    if (m_level >= Level::Sql)
        return loginfo << (m_tag.empty() ? "" : "[" + m_tag + "] ");

    return m_devnull;
}
