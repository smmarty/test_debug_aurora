/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:universal_io/io.dart';

class Package {
  Package({
    required this.key,
    required this.descEN,
    required this.descRU,
    required this.version,
    required this.isPlatformDependent,
  });

  /// Get brief description of the package
  String get desc => (Platform.localeName == 'ru_RU' ? descRU : descEN)
      .replaceAll("\n", " ")
      .replaceAll(RegExp(' +'), ' ')
      .trim();

  /// Key package (https://pub.dev/packages/<KEY>)
  final String key;

  /// Brief description of the package (EN)
  final String descEN;

  /// Brief description of the package (RU)
  final String descRU;

  /// Version package check
  final String version;

  /// Is the package platform dependent?
  final bool isPlatformDependent;
}
