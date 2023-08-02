// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus_aurora/package_info_plus_aurora_method_channel.dart';

void main() {
  MethodChannelPackageInfoPlusAurora platform =
      MethodChannelPackageInfoPlusAurora();
  const MethodChannel channel = MethodChannel('package_info_plus_aurora');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getApplicationOrg':
          return 'com.example';
        case 'getApplicationName':
          return 'path_provider_aurora';
      }
      return '';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('onGetApplicationOrg', () async {
    expect(await platform.getApplicationOrg(), 'com.example');
  });

  test('onGetApplicationName', () async {
    expect(await platform.getApplicationName(), 'path_provider_aurora');
  });
}
