/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageCrypto = PackageDialog(
  key: 'crypto',
  descEN: '''
    A set of cryptographic hashing functions for Dart.
    ''',
  descRU: '''
    Набор криптографических функций хеширования для Dart.
    ''',
  messageEN: '''
  This is a platform independent plugin used in this app, should work 
  for you too.
  ''',
  messageRU: '''
  Это плагин независимый от платформы, используется в этом приложении, 
  должен работать и у вас.
  ''',
  version: '3.0.2',
  isPlatformDependent: false,
);
