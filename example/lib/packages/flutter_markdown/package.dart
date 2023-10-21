// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageFlutterMarkdown = PackagePage(
  key: 'flutter_markdown',
  descEN: '''
    A markdown renderer for Flutter. It supports the original format, 
    but no inline HTML.
    ''',
  descRU: '''
    Рендерер уценки для Flutter. Он поддерживает исходный формат, 
    но не поддерживает встроенный HTML.
    ''',
  version: '0.6.17+4',
  isPlatformDependent: false,
  page: () => FlutterMarkdownPage(),
  init: () {
    GetIt.instance
        .registerFactory<FlutterMarkdownModel>(() => FlutterMarkdownModel());
  },
);
