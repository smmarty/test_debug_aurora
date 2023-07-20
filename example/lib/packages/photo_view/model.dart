/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [PhotoViewPage]
class PhotoViewModel extends Model {
  /// Get [ScopedModel]
  static PhotoViewModel of(BuildContext context) =>
      ScopedModel.of<PhotoViewModel>(context);
}
