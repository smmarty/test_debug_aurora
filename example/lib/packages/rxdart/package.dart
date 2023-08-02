// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageRxdart = PackagePage(
  key: 'rxdart',
  descEN: '''
    RxDart extends the capabilities of Dart Streams and StreamControllers.
    ''',
  descRU: '''
    RxDart расширяет возможности Dart Streams и StreamControllers.
    ''',
  version: '0.27.7',
  isPlatformDependent: false,
  page: () => RxdartPage(),
  init: () {
    GetIt.instance.registerFactory<RxdartModel>(() => RxdartModel());
  },
);
