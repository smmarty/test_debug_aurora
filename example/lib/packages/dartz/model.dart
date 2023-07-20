/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [DartzPage]
class DartzModel extends Model {
  /// Get [ScopedModel]
  static DartzModel of(BuildContext context) =>
      ScopedModel.of<DartzModel>(context);

  /// Example using Option from package dartz
  Option<String> getEURManSize(int size) {
    if (size < 42) return none();
    if (size < 44) return some('XS');
    if (size < 46) return some('S');
    if (size < 48) return some('M');
    if (size < 50) return some('L');
    if (size < 54) return some('XL');
    if (size < 56) return some('XXL');
    if (size < 58) return some('XXXL');
    if (size <= 62) return some('XXXXL');
    return none();
  }
}
