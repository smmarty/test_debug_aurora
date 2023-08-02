// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packagePath = PackageDialog(
  key: 'path',
  descEN: '''
    A comprehensive, cross-platform path manipulation library for Dart.
    ''',
  descRU: '''
    Комплексная кроссплатформенная библиотека управления путями для Dart.
    ''',
  messageEN: '''
  This is a platform independent plugin used in this app, should work 
  for you too.
  ''',
  messageRU: '''
  Это плагин независимый от платформы, используется в этом приложении, 
  должен работать и у вас.
  ''',
  version: '1.8.2',
  isPlatformDependent: false,
);
