/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'page.dart';
import 'model.dart';

/// Package values
final packageFlutterKeyboardVisibility = PackagePage(
  key: 'flutter_keyboard_visibility',
  descEN: '''
    React to keyboard visibility changes.
    ''',
  descRU: '''
    Реагировать на изменения видимости клавиатуры.
    ''',
  version: '5.4.1',
  isPlatformDependent: true,
  page: () => FlutterKeyboardVisibilityPage(),
  init: () {
    GetIt.instance.registerFactory<FlutterKeyboardVisibilityModel>(
        () => FlutterKeyboardVisibilityModel());
  },
);
