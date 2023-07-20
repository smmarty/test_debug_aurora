/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageEquatable = PackagePage(
  key: 'equatable',
  descEN: '''
    Being able to compare objects in Dart often involves having to override 
    the == operator as well as hashCode.
    ''',
  descRU: '''
    Возможность сравнивать объекты в Dart часто требует переопределения 
    оператора ==, а также hashCode.
    ''',
  version: '2.0.5',
  isPlatformDependent: false,
  page: () => EquatablePage(),
  init: () {
    GetIt.instance.registerFactory<EquatableModel>(() => EquatableModel());
  },
);
