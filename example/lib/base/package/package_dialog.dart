// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:universal_io/io.dart';

class PackageDialog extends Package {
  PackageDialog({
    required super.key,
    required super.descEN,
    required super.descRU,
    required super.version,
    required super.isPlatformDependent,
    required this.messageEN,
    required this.messageRU,
  });

  /// Get brief description of the package
  String get message => (Platform.localeName == 'ru_RU' ? messageRU : messageEN)
      .replaceAll("\n", " ")
      .replaceAll(RegExp(' +'), ' ')
      .trim();

  /// Message show in dialog (EN)
  final String messageEN;

  /// Message show in dialog (RU)
  final String messageRU;
}
