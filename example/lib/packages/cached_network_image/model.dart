/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [CachedNetworkImagePage]
class CachedNetworkImageModel extends Model {
  /// Get [ScopedModel]
  static CachedNetworkImageModel of(BuildContext context) =>
      ScopedModel.of<CachedNetworkImageModel>(context);
}
