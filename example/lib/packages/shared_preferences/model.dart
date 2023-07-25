/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Model for [SharedPreferencesPage]
class SharedPreferencesModel extends Model {
  /// Get [ScopedModel]
  static SharedPreferencesModel of(BuildContext context) =>
      ScopedModel.of<SharedPreferencesModel>(context);

  /// Get Aurora info
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Read shared preferences
  Map<String, dynamic>? _readValues;

  /// Public values
  Map<String, dynamic>? get readValues => _readValues;

  /// Save int value
  Future<void> setValueInt(int value) async {
    try {
      await (await _prefs).setInt('int', value);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Save bool value
  Future<void> setValueBool(bool value) async {
    try {
      await (await _prefs).setBool('bool', value);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Save double value
  Future<void> setValueDouble(double value) async {
    try {
      await (await _prefs).setDouble('double', value);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Save string value
  Future<void> setValueString(String value) async {
    try {
      await (await _prefs).setString('string', value);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Save list value
  Future<void> setValueList(List<String> value) async {
    try {
      await (await _prefs).setStringList('list', value);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Clear all data
  Future<void> clear() async {
    try {
      await (await _prefs).clear();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// Read values
  Future<void> reloadValues() async {
    try {
      final prefs = await _prefs;
      _readValues = {
        'int': prefs.getInt('int'),
        'bool': prefs.getBool('bool'),
        'double': prefs.getDouble('double'),
        'string': prefs.getString('string'),
        'list': prefs.getStringList('list'),
      };
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
