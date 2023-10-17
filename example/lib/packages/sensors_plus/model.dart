// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [SensorsPlusPage]
class SensorsPlusModel extends Model {
  /// Get [ScopedModel]
  static SensorsPlusModel of(BuildContext context) =>
      ScopedModel.of<SensorsPlusModel>(context);
}
