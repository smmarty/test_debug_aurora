/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/photo_view/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packagePhotoView = PackagePage(
  key: 'photo_view',
  descEN: '''
    A simple zoomable image/content widget for Flutter.
    ''',
  descRU: '''
    Простой масштабируемый виджет изображения/контента для Flutter.
    ''',
  version: '0.14.0',
  isPlatformDependent: false,
  page: () => PhotoViewPage(),
  init: () {
    GetIt.instance.registerFactory<PhotoViewModel>(() => PhotoViewModel());
  },
);
