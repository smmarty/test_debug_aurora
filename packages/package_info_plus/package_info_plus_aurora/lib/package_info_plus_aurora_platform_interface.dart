/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package_info_plus_aurora_method_channel.dart';

abstract class PackageInfoPlusAuroraPlatform extends PlatformInterface {
  /// Constructs a PackageInfoPlusAuroraPlatform.
  PackageInfoPlusAuroraPlatform() : super(token: _token);

  static final Object _token = Object();

  static PackageInfoPlusAuroraPlatform _instance =
      MethodChannelPackageInfoPlusAurora();

  /// The default instance of [PackageInfoPlusAuroraPlatform] to use.
  ///
  /// Defaults to [MethodChannelPackageInfoPlusAurora].
  static PackageInfoPlusAuroraPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PackageInfoPlusAuroraPlatform] when
  /// they register themselves.
  static set instance(PackageInfoPlusAuroraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getApplicationOrg() {
    throw UnimplementedError('getApplicationOrg() has not been implemented.');
  }

  Future<String?> getApplicationName() {
    throw UnimplementedError('getApplicationName() has not been implemented.');
  }
}
