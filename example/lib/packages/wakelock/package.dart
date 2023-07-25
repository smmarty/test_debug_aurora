/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/wakelock/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageWakelock = PackagePage(
  key: 'wakelock',
  descEN: '''
    Plugin that allows you to keep the device screen awake, i.e. 
    prevent the screen from sleeping.
    ''',
  descRU: '''
    Плагин, который позволяет держать экран устройства в активном состоянии, 
    т. е. предотвращать переход экрана в спящий режим.
    ''',
  version: '0.6.2',
  isPlatformDependent: true,
  page: () => WakelockPage(),
  init: () {
    GetIt.instance.registerFactory<WakelockModel>(() => WakelockModel());
  },
);
