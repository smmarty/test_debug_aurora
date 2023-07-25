/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [ProviderPage]
class ProviderModel extends Model {
  /// Get [ScopedModel]
  static ProviderModel of(BuildContext context) =>
      ScopedModel.of<ProviderModel>(context);
}
