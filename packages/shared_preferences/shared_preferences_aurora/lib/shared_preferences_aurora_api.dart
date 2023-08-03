// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class SharedPreferencesAuroraApi {
  final JsonDecoder decoder = const JsonDecoder();
  final String fileName;

  SharedPreferencesAuroraApi(this.fileName);

  /// Remove all data by prifix
  Future<bool> clearWithPrefix(String prefix) async {
    final map = await _read();
    final filtered = {
      for (final key in map.keys)
        if (!key.startsWith(prefix)) key: map[key]
    };
    await _save(filtered);
    return true;
  }

  /// Get all data by prifix
  Future<Map<Object?, Object?>> getAllWithPrefix(String prefix) async {
    final map = await _read();
    return {
      for (final key in map.keys)
        if (key.startsWith(prefix)) key: map[key]
    };
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

  /// Add value and save data
  Future<bool> setData(String key, dynamic value) async {
    final map = await _read();
    map[key] = value;
    await _save(map);
    return true;
  }

  /// Get file with data
  Future<File> _getFile() async {
    return File(p.join(
      (await getTemporaryDirectory()).path,
      fileName,
    )).create(recursive: true);
  }

  /// Read file
  Future<Map<String, dynamic>> _read() async {
    final file = await _getFile();
    final value = await file.readAsString();
    return value.isEmpty ? {} : decoder.convert(value);
  }

  /// Save data to file
  Future<void> _save(Map<String, dynamic> data) async {
    final file = await _getFile();
    final value = json.encode(data);
    await file.writeAsString(value);
  }
}
