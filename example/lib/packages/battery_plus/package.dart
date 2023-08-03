// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/battery_plus/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageBatteryPlus = PackagePage(
  key: 'battery_plus',
  descEN: '''
    A Flutter plugin to access various information about the 
    battery of the device the app is running on.
    ''',
  descRU: '''
    Плагин Flutter для доступа к различной информации о
    аккумулятор устройства, на котором запущено приложение.
    ''',
  version: '4.0.1',
  isPlatformDependent: true,
  page: () => BatteryPlusPage(),
  init: () {
    GetIt.instance.registerFactory<BatteryPlusModel>(() => BatteryPlusModel());
  },
);
