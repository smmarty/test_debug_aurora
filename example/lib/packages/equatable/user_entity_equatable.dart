// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
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
