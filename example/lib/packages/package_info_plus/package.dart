// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/package_info_plus/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packagePackageInfoPlus = PackagePage(
  key: 'package_info_plus',
  descEN: '''
    This Flutter plugin provides an API for querying information about 
    an application package.
    ''',
  descRU: '''
    Этот плагин Flutter предоставляет API для запроса информации о 
    пакете приложения.
    ''',
  version: '3.1.2',
  isPlatformDependent: true,
  page: () => PackageInfoPlusPage(),
  init: () {
    GetIt.instance
        .registerFactory<PackageInfoPlusModel>(() => PackageInfoPlusModel());
  },
);
