/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/app.dart';
import 'package:flutter_example_packages/base/build/build.release.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';

void main() {
  setupDI(BuildReleaseConfig());
  runApp(const MyApp());
}
