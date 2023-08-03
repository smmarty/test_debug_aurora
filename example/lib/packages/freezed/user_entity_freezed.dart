// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity_freezed.freezed.dart';
part 'user_entity_freezed.g.dart';

@freezed
class UserEntityFreezed with _$UserEntityFreezed {
  const factory UserEntityFreezed({
    required String name,
    required String email,
    required int age,
  }) = _UserEntityFreezed;

  factory UserEntityFreezed.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFreezedFromJson(json);
}
