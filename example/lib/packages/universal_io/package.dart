/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageUniversalIO = PackageDialog(
  key: 'universal_io',
  descEN: '''
    A cross-platform dart:io that works on all platforms, 
    including browsers.
    ''',
  descRU: '''
    Кроссплатформенный dart:io, который работает на всех платформах,
    включая браузеры.
    ''',
  messageEN: '''
  This is a platform independent plugin used in this app, should work 
  for you too.
  ''',
  messageRU: '''
  Это плагин независимый от платформы, используется в этом приложении, 
  должен работать и у вас.
  ''',
  version: '2.2.0',
  isPlatformDependent: false,
);
