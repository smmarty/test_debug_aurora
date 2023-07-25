/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wakelock/wakelock.dart';

/// Model for [WakelockPage]
class WakelockModel extends Model {
  /// Get [ScopedModel]
  static WakelockModel of(BuildContext context) =>
      ScopedModel.of<WakelockModel>(context);

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Check is enable Wakelock
  Future<bool?> isEnable() async {
    try {
      return await Wakelock.enabled;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Set state Wakelock
  Future<void> setStateWakelock(bool enable) async {
    try {
      await Wakelock.toggle(enable: enable);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
