/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/xdga_directories/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageXdgaDirectories = PackagePage(
  key: 'xdga_directories',
  descEN: '''
    A Dart package for reading XDG directory configuration information 
    on Aurora OS.
    ''',
  descRU: '''
    Пакет Dart для чтения информации о конфигурации каталога XDG
    на ОС Аврора.
    ''',
  version: '0.0.1',
  isPlatformDependent: true,
  page: () => XdgaDirectoriesPage(),
  init: () {
    GetIt.instance
        .registerFactory<XdgaDirectoriesModel>(() => XdgaDirectoriesModel());
  },
);
