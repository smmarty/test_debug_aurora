// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageDartz = PackagePage(
  key: 'dartz',
  descEN: '''
    Functional programming in Dart.
    ''',
  descRU: '''
    Функциональное программирование в Dart.
    ''',
  version: '0.10.1',
  isPlatformDependent: false,
  page: () => DartzPage(),
  init: () {
    GetIt.instance.registerFactory<DartzModel>(() => DartzModel());
  },
);
