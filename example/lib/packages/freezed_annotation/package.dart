// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageFreezedAnnotation = PackageDialog(
  key: 'freezed_annotation',
  descEN: '''
    Annotations for freezed. This package does nothing without freezed.
    ''',
  descRU: '''
    Аннотации для freezed. Этот пакет ничего не делает без freezed.
    ''',
  messageEN: '''
    This is a platform independent plugin used in this application in the demo 
    of the freezed plugin.
    ''',
  messageRU: '''
    Это плагин независимый от платформы, используется в этом приложении в 
    демострации работы плагина freezed.
    ''',
  version: '2.4.1',
  isPlatformDependent: false,
);
