/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [RxdartPage]
class RxdartModel extends Model {
  /// Get [ScopedModel]
  static RxdartModel of(BuildContext context) =>
      ScopedModel.of<RxdartModel>(context);

  final listObjects = [1, 'First', 2, 'Second', 3, 'Third', null];

  /// Example of using rxdart
  Future<List<String>> getNumberList() {
    return Stream.fromIterable(listObjects)
        .doOnEach((notification) {
          debugPrint(notification.toString());
        })
        .whereNotNull()
        .whereType<String>()
        .toList();
  }
}
