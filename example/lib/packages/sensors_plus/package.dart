// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageSensorsPlus = PackagePage(
  key: 'sensors_plus',
  descEN: '''
    A Flutter plugin to access the accelerometer, gyroscope, 
    magnetometer sensors, etc.
    ''',
  descRU: '''
    Плагин Flutter для доступа к датчикам акселерометра, 
    гироскопа, магнитометра и т.д.
    ''',
  version: '3.0.2',
  isPlatformDependent: true,
  page: () => SensorsPlusPage(),
  init: () {
    GetIt.instance.registerFactory<SensorsPlusModel>(() => SensorsPlusModel());
  },
);
