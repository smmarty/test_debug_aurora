// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/path_provider/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packagePathProvider = PackagePage(
  key: 'path_provider',
  descEN: '''
    A Flutter plugin for finding commonly used locations on the filesystem. 
    Supports Android, iOS, Linux, macOS, Windows and Aurora OS. 
    Not all methods are supported on all platforms.
    ''',
  descRU: '''
     Плагин Flutter для поиска часто используемых мест в файловой системе.
     Поддерживает Android, iOS, Linux, macOS, Windows и ОС Aurora.
     Не все методы поддерживаются на всех платформах.
    ''',
  version: '2.0.15',
  isPlatformDependent: true,
  page: () => PathProviderPage(),
  init: () {
    GetIt.instance
        .registerFactory<PathProviderModel>(() => PathProviderModel());
  },
);
