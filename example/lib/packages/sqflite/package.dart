/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageSqflite = PackagePage(
  key: 'sqflite',
  descEN: '''
    SQLite plugin for Flutter. Supports iOS, Android, MacOS and Aurora OS.
    ''',
  descRU: '''
    Плагин SQLite для Flutter. Поддерживает iOS, Android, MacOS и ОС Аврора.
    ''',
  version: '2.2.6',
  isPlatformDependent: true,
  page: () => SqflitePage(),
  init: () {
    GetIt.instance.registerFactory<SqfliteModel>(() => SqfliteModel());
  },
);
