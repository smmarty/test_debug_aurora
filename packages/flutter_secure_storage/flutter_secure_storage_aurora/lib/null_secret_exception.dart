// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
class NullSecretException implements Exception {
  @override
  String toString() {
    return 'NullSecretException: Oops! Before use, you need to specify the encryption key';
  }
}
