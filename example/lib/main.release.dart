/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/app.dart';
import 'package:flutter_example_packages/base/build/build.debug.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';

void main() {
  setupDI(BuildDebugConfig());
  runApp(const MyApp());
}
