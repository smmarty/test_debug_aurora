/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package_info_plus_aurora_platform_interface.dart';
import 'package:package_info_plus_platform_interface/package_info_platform_interface.dart';
import 'package:package_info_plus_platform_interface/package_info_data.dart';

class PackageInfoPlusAurora extends PackageInfoPlatform {
  /// Register this dart class as the platform implementation for aurora
  static void registerWith() {
    PackageInfoPlatform.instance = PackageInfoPlusAurora();
  }

  final _platform = PackageInfoPlusAuroraPlatform.instance;

  @override
  Future<PackageInfoData> getAll() async {
    final versionJson = await _getVersionJson();
    return PackageInfoData(
      appName: versionJson['app_name'] ?? '',
      packageName: versionJson['package_name'] ?? '',
      version: versionJson['version'] ?? '',
      buildNumber: versionJson['build_number'] ?? '',
      buildSignature: '',
    );
  }

  Future<Map<String, dynamic>> _getVersionJson() async {
    try {
      // Get package from aurora platform
      final org = await _platform.getApplicationOrg();
      final name = await _platform.getApplicationName();
      final packageName = '$org.$name';

      // Get application name
      final desktop =
          (await File('/usr/share/applications/$packageName.desktop')
                  .readAsLines())
              .where((element) => element.contains('Name='));

      // @todo
      // Get application versions
      // rpm -q --queryformat %{VERSION} <package>
      // not working even with Compatibility permission

      return <String, dynamic>{
        'app_name': desktop.isNotEmpty ? desktop.first.substring(5) : null,
        'package_name': packageName,
        'version': '',
        'build_number': '',
      };
    } catch (e) {
      debugPrint(e.toString());
      return <String, dynamic>{};
    }
  }
}
