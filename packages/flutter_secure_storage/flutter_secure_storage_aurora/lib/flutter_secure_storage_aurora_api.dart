// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart' as crypto;

class FlutterSecureStorageAuroraApi {
  final JsonDecoder decoder = const JsonDecoder();

  final String _secret;
  final String _fileName;
  Map<String, dynamic>? _data;

  FlutterSecureStorageAuroraApi(this._secret, this._fileName);

  /// Get value
  Future<dynamic> getData(String key) async {
    final map = await _read();
    return map[key];
  }

  /// Get all data
  Future<Map<String, dynamic>> getAll() async {
    return await _read();
  }

  /// Check has value
  Future<bool> containsKey(String key) async {
    final map = await _read();
    return map.containsKey(key);
  }

  /// Add value and save data
  Future<bool> setData(String key, dynamic value) async {
    final map = await _read();
    map[key] = value;
    await _save(map);
    return true;
  }

  /// Remove one value
  Future<bool> remove(String key) async {
    final map = await _read();
    if (map.containsKey(key)) {
      map.remove(key);
      await _save(map);
      return true;
    }
    return false;
  }

  /// Clear all data - remove file
  Future<bool> clear() async {
    final file = await _getFile();
    await file.delete();
    _data = null;
    return true;
  }

  /// Get file with data
  Future<File> _getFile() async {
    return File(p.join(
      (await getTemporaryDirectory()).path,
      _fileName,
    )).create(recursive: true);
  }

  /// Read file or get from cache
  Future<Map<String, dynamic>> _read() async {
    if (_data == null) {
      final file = await _getFile();
      final read = await file.readAsString();
      final value = read.isEmpty ? '' : _decrypt(read);
      _data = value.isEmpty ? {} : decoder.convert(value);
    }
    return Future.value(_data);
  }

  /// Save data to file
  Future<void> _save(Map<String, dynamic> data) async {
    final file = await _getFile();
    final value = json.encode(data);
    await file.writeAsString(_encrypt(value));
  }

  /// Encrypt data in file
  String _encrypt(String value) {
    var ivStr = crypto.sha256.convert(utf8.encode(_secret)).toString().substring(0, 16);
    var keyStr = crypto.sha256.convert(utf8.encode(_secret)).toString().substring(0, 32);

    encrypt.IV iv = encrypt.IV.fromUtf8(ivStr);
    encrypt.Key key = encrypt.Key.fromUtf8(keyStr);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    return encrypter.encrypt(value, iv: iv).base64;
  }

  /// Decrypt data in file
  String _decrypt(String value) {
    var ivStr = crypto.sha256.convert(utf8.encode(_secret)).toString().substring(0, 16);
    var keyStr = crypto.sha256.convert(utf8.encode(_secret)).toString().substring(0, 32);

    encrypt.IV iv = encrypt.IV.fromUtf8(ivStr);
    encrypt.Key key = encrypt.Key.fromUtf8(keyStr);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    return encrypter.decrypt64(value, iv: iv);
  }
}
