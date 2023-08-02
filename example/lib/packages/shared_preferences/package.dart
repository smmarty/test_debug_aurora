// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/shared_preferences/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageSharedPreferences = PackagePage(
  key: 'shared_preferences',
  descEN: '''
    Wraps platform-specific persistent storage for simple data.
    ''',
  descRU: '''
    Обертывает постоянное хранилище для конкретных платформ для простых данных.
    ''',
  version: '2.1.2',
  isPlatformDependent: true,
  page: () => SharedPreferencesPage(),
  init: () {
    GetIt.instance.registerFactory<SharedPreferencesModel>(
        () => SharedPreferencesModel());
  },
);
