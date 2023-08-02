/**
 * SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
 * SPDX-License-Identifier: BSD-3-Clause
 */
#include <sqflite_aurora/utils.h>

namespace utils {

error::error(std::string message)
    : m_message(std::move(message))
{}

utils::error error::none()
{
    return {};
}

error::operator bool() const
{
    return m_message.has_value();
}

const std::string &error::message() const
{
    return m_message.value();
}

} /* namespace utils */
