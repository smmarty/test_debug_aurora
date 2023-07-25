/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageGetIt = PackageDialog(
  key: 'get_it',
  descEN: '''
    This is a simple Service Locator for Dart and Flutter projects with some 
    additional goodies highly inspired by Splat.
    ''',
  descRU: '''
    Это простой сервис-локатор для проектов Dart и Flutter с некоторыми
    дополнительные вкусности, вдохновленные Splat.
    ''',
  messageEN: '''
  This is a platform independent plugin used in this app, should work 
  for you too.
  ''',
  messageRU: '''
  Это плагин независимый от платформы, используется в этом приложении, 
  должен работать и у вас.
  ''',
  version: '7.6.0',
  isPlatformDependent: false,
);
