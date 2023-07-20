/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:path_provider_aurora/path_provider_aurora.dart';
import 'null_secret_exception.dart';
import 'flutter_secure_storage_aurora_api.dart';

class FlutterSecureStorageAurora extends FlutterSecureStoragePlatform {
  static FlutterSecureStorageAuroraApi? _api;

  /// Before use, you need to specify the encryption key
  /// https://pub.dev/packages/encrypt
  /// Encrypter(AES(key))
  /// secure-random --length 16 --base 16
  /// You can generate a secret key based on user data, as an example of a hash pincode
  static void setSecret(String secret) {
    _api = FlutterSecureStorageAuroraApi(
      secret,
      '.flutter_secure_storage.json',
    );
  }

  static void registerWith() {
    FlutterSecureStoragePlatform.instance = FlutterSecureStorageAurora();
  }

  static FlutterSecureStorageAuroraApi _getAPI() {
    if (_api == null) {
      throw NullSecretException();
    }
    return _api!;
  }

  @override
  Future<bool> containsKey({
    required String key,
    required Map<String, String> options,
  }) async =>
      _getAPI().containsKey(key);

  @override
  Future<void> delete({
    required String key,
    required Map<String, String> options,
  }) async =>
      _getAPI().remove(key);

  @override
  Future<void> deleteAll({
    required Map<String, String> options,
  }) async =>
      _getAPI().clear();

  @override
  Future<String?> read({
    required String key,
    required Map<String, String> options,
  }) async =>
      await _getAPI().getData(key);

  @override
  Future<Map<String, String>> readAll({
    required Map<String, String> options,
  }) async =>
      (await _getAPI().getAll()).cast();

  @override
  Future<void> write({
    required String key,
    required String value,
    required Map<String, String> options,
  }) async =>
      _getAPI().setData(key, value);
}
