/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageProvider = PackagePage(
  key: 'provider',
  descEN: '''
    A wrapper around InheritedWidget to make them easier to use and more 
    reusable.
    ''',
  descRU: '''
    Оболочка вокруг InheritedWidget, чтобы сделать их более простыми в 
    использовании и более удобными для повторного использования.
    ''',
  version: '6.0.5',
  isPlatformDependent: false,
  page: () => ProviderPage(),
  init: () {
    GetIt.instance.registerFactory<ProviderModel>(() => ProviderModel());
  },
);
