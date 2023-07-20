/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageFreezed = PackagePage(
  key: 'freezed',
  descEN: '''
    Code generator for data-classes/unions/pattern-matching/cloning.
    ''',
  descRU: '''
    Генератор кода для классов данных/объединений/сопоставления 
    с образцом/клонирования.
    ''',
  version: '2.3.3',
  isPlatformDependent: false,
  page: () => FreezedPage(),
  init: () {
    GetIt.instance.registerFactory<FreezedModel>(() => FreezedModel());
  },
);
