// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/foundation.dart';

@immutable
class UserEntity {
  const UserEntity({
    required this.name,
    required this.email,
    required this.age,
  });

  final String name;
  final String email;
  final int age;

  @override
  String toString() {
    return 'UserEntity('
        '$name,'
        '$email,'
        '$age'
        ')';
  }

  @override
  bool operator ==(dynamic other) {
    return other is UserEntity &&
        other.name == name &&
        other.email == email &&
        other.age == age;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      name,
      email,
      age,
    );
  }
}
