/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageTranslator = PackagePage(
  key: 'translator',
  descEN: '''
    Free Google Translate API for Dart.
    ''',
  descRU: '''
    Бесплатный API Google Translate для Dart.
    ''',
  version: '0.1.7',
  isPlatformDependent: false,
  page: () => TranslatorPage(),
  init: () {
    GetIt.instance.registerFactory<TranslatorModel>(() => TranslatorModel());
  },
);
