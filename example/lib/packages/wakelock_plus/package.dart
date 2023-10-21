// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/wakelock_plus/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageWakelockPlus = PackagePage(
  key: 'wakelock_plus',
  descEN: '''
    Plugin that allows you to keep the device screen awake, i.e. 
    prevent the screen from sleeping.
    ''',
  descRU: '''
    Плагин, который позволяет держать экран устройства в активном состоянии, 
    т. е. предотвращать переход экрана в спящий режим.
    ''',
  version: '1.1.1',
  isPlatformDependent: true,
  page: () => WakelockPlusPage(),
  init: () {
    GetIt.instance.registerFactory<WakelockPlusModel>(() => WakelockPlusModel());
  },
);
