/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package_info_plus_aurora_platform_interface.dart';

/// An implementation of [PackageInfoPlusAuroraPlatform] that uses method channels.
class MethodChannelPackageInfoPlusAurora extends PackageInfoPlusAuroraPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('package_info_plus_aurora');

  @override
  Future<String?> getApplicationOrg() async {
    return await methodChannel.invokeMethod<String>('getApplicationOrg');
  }

  @override
  Future<String?> getApplicationName() async {
    return await methodChannel.invokeMethod<String>('getApplicationName');
  }
}
