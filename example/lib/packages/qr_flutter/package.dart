// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:get_it/get_it.dart';

import 'model.dart';
import 'page.dart';

/// Package values
final packageQrFlutter = PackagePage(
  key: 'qr_flutter',
  descEN: '''
    QR.Flutter is a Flutter library for simple and fast QR code rendering 
    via a Widget or custom painter.
    ''',
  descRU: '''
    ПQR.Flutter — это библиотека Flutter для простого и быстрого рендеринга 
    QR-кода с помощью виджета или пользовательского рисовальщика.
    ''',
  version: '4.0.0',
  isPlatformDependent: false,
  page: () => QrFlutterPage(),
  init: () {
    GetIt.instance.registerFactory<QrFlutterModel>(() => QrFlutterModel());
  },
);
