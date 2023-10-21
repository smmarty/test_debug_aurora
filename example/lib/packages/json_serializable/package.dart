// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageJsonSerializable = PackageDialog(
  key: 'json_serializable',
  descEN: '''
    Provides Dart Build System builders for handling JSON.
    ''',
  descRU: '''
    Предоставляет Dart Build System System для обработки JSON.
    ''',
  messageEN: '''
    This is a platform independent plugin used in this application in the demo 
    of the freezed plugin.
    ''',
  messageRU: '''
    Это плагин независимый от платформы, используется в этом приложении в 
    демострации работы плагина freezed.
    ''',
  version: '6.7.1',
  isPlatformDependent: false,
);
