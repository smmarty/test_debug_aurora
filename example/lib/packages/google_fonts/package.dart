// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageGoogleFonts = PackageDialog(
  key: 'google_fonts',
  descEN: '''
    A Flutter package to use fonts from fonts.google.com.
    ''',
  descRU: '''
    Пакет Flutter для использования шрифтов с fonts.google.com.
    ''',
  messageEN: '''
  This is a platform dependent plugin used in this app, should work 
  for you too.
  ''',
  messageRU: '''
  Это плагин зависимый от платформы, используется в этом приложении, 
  должен работать и у вас.
  ''',
  version: '6.1.0',
  isPlatformDependent: true,
);
