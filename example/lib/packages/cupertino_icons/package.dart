// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageCupertinoIcons = PackageDialog(
  key: 'cupertino_icons',
  descEN: '''
    This is an asset repo containing the default set of icon assets 
    used by Flutter's Cupertino widgets.
    ''',
  descRU: '''
    Это репозиторий ресурсов, содержащий набор ресурсов значков по умолчанию
    используется виджетами Flutter Cupertino.
    ''',
  messageEN: '''
  This is a platform independent plugin used in this app, should work 
  for you too.
  ''',
  messageRU: '''
  Это плагин независимый от платформы, используется в этом приложении, 
  должен работать и у вас.
  ''',
  version: '1.0.5',
  isPlatformDependent: false,
);
