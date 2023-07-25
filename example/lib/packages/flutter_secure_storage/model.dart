/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_aurora/flutter_secure_storage_aurora.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [FlutterSecureStoragePage]
class FlutterSecureStorageModel extends Model {
  /// Get [ScopedModel]
  static FlutterSecureStorageModel of(BuildContext context) =>
      ScopedModel.of<FlutterSecureStorageModel>(context);

  final _secureStorage = const FlutterSecureStorage();

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Save success
  bool _isSuccess = false;

  /// Public success
  bool get isSuccess => _isSuccess;

  /// Value for read form secure storage
  String _readValue = "";

  /// Public read value
  String get readValue => _readValue;

  // Get data from secure storage
  Future<void> read({
    required String key,
    required String password,
  }) async {
    try {
      // Update secret key
      _updateByPassword(password);
      // Read data
      _readValue = await _secureStorage.read(key: key) ?? "Not found";
    } catch (e) {
      _readValue = "Error password";
    }
    notifyListeners();
  }

  // Write new data in secure storage
  Future<void> write({
    required String key,
    required String value,
    required String password,
  }) async {
    try {
      // Update secret key
      _updateByPassword(password);
      // Clear old data
      await _secureStorage.deleteAll();
      // Save new data
      await _secureStorage.write(key: key, value: value);
      // Show success
      _isSuccess = true;
      // Close success
      Future.delayed(const Duration(milliseconds: 1500), () {
        _isSuccess = false;
        notifyListeners();
      });
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Update password
  void _updateByPassword(
    String password,
  ) {
    // https://pub.dev/packages/encrypt
    // Encrypter(AES(key))
    // secure-random --length 16 --base 16
    // You can generate a secret key based on user data, as an example of a hash pin-code
    FlutterSecureStorageAurora.setSecret(
      _getPasswordFromString(password),
    );
  }

  /// Generate secure key 32 length from string password
  String _getPasswordFromString(
    String password,
  ) {
    return md5.convert(utf8.encode(password)).toString();
  }

  /// Clear value if change values
  void clearReadValue() {
    _readValue = "";
    notifyListeners();
  }
}
