/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
class NullSecretException implements Exception {
  @override
  String toString() {
    return 'NullSecretException: Oops! Before use, you need to specify the encryption key';
  }
}
