/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/widgets.dart';
import 'package:flutter_example_packages/packages/freezed/user_entity.dart';
import 'package:flutter_example_packages/packages/freezed/user_entity_freezed.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [FreezedPage]
class FreezedModel extends Model {
  /// Get [ScopedModel]
  static FreezedModel of(BuildContext context) =>
      ScopedModel.of<FreezedModel>(context);

  UserEntity userEntity = UserEntity.fromJson(const {
    'name': 'Default',
    'email': 'default@yandex.ru',
    'age': 12,
  });

  UserEntityFreezed userEntityFreezed = UserEntityFreezed.fromJson(const {
    'name': 'Default',
    'email': 'default@yandex.ru',
    'age': 12,
  });
}
