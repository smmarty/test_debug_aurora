// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/flutter_local_notifications/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageFlutterLocalNotifications = PackagePage(
  key: 'flutter_local_notifications',
  descEN: '''
    A cross platform plugin for displaying local notifications.
    ''',
  descRU: '''
    Кроссплатформенный плагин для отображения локальных уведомлений.
    ''',
  version: '14.1.1',
  isPlatformDependent: true,
  page: () => FlutterLocalNotificationsPage(),
  init: () {
    GetIt.instance.registerFactory<FlutterLocalNotificationsModel>(
        () => FlutterLocalNotificationsModel());
  },
);
