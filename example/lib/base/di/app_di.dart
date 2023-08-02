// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/build/build.config.dart';
import 'package:flutter_example_packages/pages/home/model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// Initialization application DI
void setupDI(BuildConfig config) {
  getIt
    ..registerSingleton(config)
    ..registerFactory(() => HomeModel());
}
