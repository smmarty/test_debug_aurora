/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserEntityEquatable extends Equatable {
  const UserEntityEquatable({
    required this.name,
    required this.email,
    required this.age,
  });

  final String name;
  final String email;
  final int age;

  @override
  List<Object> get props => [name, email, age];

  @override
  bool get stringify => true;
}
