/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Model for [PackageInfoPlusPage]
class PackageInfoPlusModel extends Model {
  /// Get [ScopedModel]
  static PackageInfoPlusModel of(BuildContext context) =>
      ScopedModel.of<PackageInfoPlusModel>(context);

  /// Get [PackageInfo]
  Future<PackageInfo> get _packageInfo async =>
      await PackageInfo.fromPlatform();

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Get package
  Future<String?> getPackageName() async {
    try {
      return (await _packageInfo).packageName;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Get application name
  Future<String?> getApplicationName() async {
    try {
      return (await _packageInfo).appName;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }
}
