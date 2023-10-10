// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Model for [WakelockPlusPage]
class WakelockPlusModel extends Model {
  /// Get [ScopedModel]
  static WakelockPlusModel of(BuildContext context) =>
      ScopedModel.of<WakelockPlusModel>(context);

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Check is enable Wakelock
  Future<bool?> isEnable() async {
    try {
      return await WakelockPlus.enabled;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Set state Wakelock
  Future<void> setStateWakelockPlus(bool enable) async {
    try {
      await WakelockPlus.toggle(enable: enable);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
