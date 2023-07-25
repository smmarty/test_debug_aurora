/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:battery_plus/battery_plus.dart';

/// Model for [BatteryPlusPage]
class BatteryPlusModel extends Model {
  /// Get [ScopedModel]
  static BatteryPlusModel of(BuildContext context) =>
      ScopedModel.of<BatteryPlusModel>(context);

  final _battery = Battery();

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Get battery level in percent 0-100
  Future<int?> getBatteryLevel() async {
    try {
      return await _battery.batteryLevel;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Get status
  Future<BatteryState?> getBatteryState() async {
    try {
      return await _battery.batteryState;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Check is enable save mode
  Future<bool?> isInBatterySaveMode() async {
    try {
      return await _battery.isInBatterySaveMode;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Stream change state
  Stream<BatteryState> onBatteryStateChanged() async* {
    try {
      yield await _battery.batteryState;
      await for (final state in _battery.onBatteryStateChanged) {
        yield state;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
