/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:flutter_example_packages/packages/equatable/user_entity.dart';
import 'package:flutter_example_packages/packages/equatable/user_entity_equatable.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [EquatablePage]
class EquatableModel extends Model {
  /// Get [ScopedModel]
  static EquatableModel of(BuildContext context) =>
      ScopedModel.of<EquatableModel>(context);

  UserEntity userEntity = const UserEntity(
    name: 'Default',
    email: 'default@yandex.ru',
    age: 12,
  );

  UserEntityEquatable userEntityEquatable = const UserEntityEquatable(
    name: 'Equatable',
    email: 'default@yandex.ru',
    age: 12,
  );
}
