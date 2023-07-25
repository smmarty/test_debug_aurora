/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/device_info_plus/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageDeviceInfoPlus = PackagePage(
  key: 'device_info_plus',
  descEN: '''
    Get current device information from within the Flutter application.
    ''',
  descRU: '''
    Получите текущую информацию об устройстве из приложения Flutter.
    ''',
  version: '8.2.2',
  isPlatformDependent: true,
  page: () => DeviceInfoPlusPage(),
  init: () {
    GetIt.instance
        .registerFactory<DeviceInfoPlusModel>(() => DeviceInfoPlusModel());
  },
);
