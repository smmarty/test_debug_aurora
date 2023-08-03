// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/cached_network_image/page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';

/// Package values
final packageCachedNetworkImage = PackagePage(
  key: 'cached_network_image',
  descEN: '''
    A flutter library to show images from the internet 
    and keep them in the cache directory.
    ''',
  descRU: '''
    Библиотека флаттера для отображения изображений из 
    Интернета и хранения их в каталоге кеша.
    ''',
  version: '3.2.3',
  isPlatformDependent: true,
  page: () => CachedNetworkImagePage(),
  init: () {
    GetIt.instance.registerFactory<CachedNetworkImageModel>(
        () => CachedNetworkImageModel());
  },
);
