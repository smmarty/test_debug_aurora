// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageBuildRunner = PackageDialog(
  key: 'build_runner',
  descEN: '''
    The build_runner package provides a concrete way of generating files using 
    Dart code. Files are always generated directly on disk, and rebuilds 
    are incremental - inspired by tools such as Bazel.
    ''',
  descRU: '''
    Пакет build_runner предоставляет конкретный способ создания файлов с 
    использованием кода Dart. Файлы всегда генерируются непосредственно на 
    диске и перестраиваются являются инкрементными — вдохновлены такими 
    инструментами, как Bazel.
    ''',
  messageEN: '''
    This is a platform independent plugin used in this app, should work 
    for you too.
    ''',
  messageRU: '''
    Это плагин независимый от платформы, используется в этом приложении, 
    должен работать и у вас.
    ''',
  version: '2.3.3',
  isPlatformDependent: false,
);
