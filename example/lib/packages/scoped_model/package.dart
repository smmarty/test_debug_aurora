/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageScopedModel = PackageDialog(
  key: 'scoped_model',
  descEN: '''
    A set of utilities that allow you to easily pass a data Model
    from a parent Widget down to its descendants.
    ''',
  descRU: '''
    Набор утилит, позволяющих легко передать Модель данных
     от родительского виджета до его потомков.
    ''',
  messageEN: '''
  This is a platform independent plugin used in this app, should work 
  for you too.
  ''',
  messageRU: '''
  Это плагин независимый от платформы, используется в этом приложении, 
  должен работать и у вас.
  ''',
  version: '2.0.0',
  isPlatformDependent: false,
);
