// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageIntl = PackageDialog(
  key: 'intl',
  descEN: '''
    Provides internationalization and localization facilities, 
    including message translation, plurals and genders, 
    date/number formatting and parsing, and bidirectional text.
    ''',
  descRU: '''
    Предоставляет средства интернационализации и локализации,
    включая перевод сообщений, множественное число и пол,
    форматирование и разбор даты/числа, а также двунаправленный текст.
    ''',
  messageEN: '''
    This is a platform independent plugin used in this app, should work 
    for you too.
    ''',
  messageRU: '''
    Это плагин независимый от платформы, используется в этом приложении, 
    должен работать и у вас.
    ''',
  version: '0.18.1',
  isPlatformDependent: false,
);
