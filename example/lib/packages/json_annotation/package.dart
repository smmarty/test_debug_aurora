/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter_example_packages/base/package/package_dialog.dart';

/// Package values
final packageJsonAnnotation = PackageDialog(
  key: 'json_annotation',
  descEN: '''
    Defines the annotations used by json_serializable to create code for 
    JSON serialization and deserialization.
    ''',
  descRU: '''
    Определяет аннотации, используемые json_serializable для создания кода для
    JSON Serialization и Deserialization.
    ''',
  messageEN: '''
    This is a platform independent plugin used in this application in the demo 
    of the freezed plugin.
    ''',
  messageRU: '''
    Это плагин независимый от платформы, используется в этом приложении в 
    демострации работы плагина freezed.
    ''',
  version: '4.8.0',
  isPlatformDependent: false,
);
