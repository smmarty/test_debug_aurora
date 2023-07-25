/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/foundation.dart';

@immutable
class UserEntity {
  const UserEntity({
    required this.name,
    required this.email,
    required this.age,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
    );
  }

  final String name;
  final String email;
  final int age;

  UserEntity copyWith({
    String? name,
    String? email,
    int? age,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'UserEntity('
        'name: $name'
        'email: $email'
        'age: $age'
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
