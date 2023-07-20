/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageFlutterCacheManager = PackageDialog(
  key: 'flutter_cache_manager',
  descEN: '''
    CacheManager v2 introduced some breaking changes when configuring 
    a custom CacheManager.
    ''',
  descRU: '''
    В CacheManager v2 были внесены некоторые критические изменения при 
    настройке пользовательского CacheManager.
    ''',
  messageEN: '''
  This is a platform dependent plugin, used in a plugin
  cached_network_image should work for you too.
  ''',
  messageRU: '''
  Это плагин зависимый от платформы, используется в плагине 
  cached_network_image, должен работать и у вас.
  ''',
  version: '3.3.0',
  isPlatformDependent: true,
);
