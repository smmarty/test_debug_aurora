/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [QrFlutterPage]
class QrFlutterModel extends Model {
  /// Get [ScopedModel]
  static QrFlutterModel of(BuildContext context) =>
      ScopedModel.of<QrFlutterModel>(context);
}
