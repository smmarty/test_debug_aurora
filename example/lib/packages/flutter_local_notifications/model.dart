/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [FlutterLocalNotificationsPage]
class FlutterLocalNotificationsModel extends Model {
  /// Get [ScopedModel]
  static FlutterLocalNotificationsModel of(BuildContext context) =>
      ScopedModel.of<FlutterLocalNotificationsModel>(context);

  final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  final notificationID = 1;

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Show local notification
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    try {
      // Cansel if already run
      await notification.cancel(notificationID);
      // Show notification
      await notification.show(
        notificationID,
        title,
        body,
        null,
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
