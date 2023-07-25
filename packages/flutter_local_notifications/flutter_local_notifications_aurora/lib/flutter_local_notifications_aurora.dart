/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:flutter_local_notifications_aurora/org_freedesktop_notifications.dart';
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FlutterLocalNotificationsAurora
    extends FlutterLocalNotificationsPlatform {
  /// Registers this class as the default instance of [FlutterLocalNotificationsPlatform].
  static void registerWith() {
    FlutterLocalNotificationsPlatform.instance =
        FlutterLocalNotificationsAurora();
  }

  final Map<int, List<int>> auroraIDs = {};

  @override
  Future<void> show(
    int id,
    String? title,
    String? body, {
    String? payload,
  }) async {
    final appName = (await PackageInfo.fromPlatform()).appName;
    final client = DBusClient.session();

    final object = OrgFreedesktopNotifications(
        client,
        'org.freedesktop.Notifications',
        DBusObjectPath('/org/freedesktop/Notifications'));

    auroraIDs[id] = auroraIDs[id] ?? [];
    auroraIDs[id]!.add(await object.callNotify(
      appName,
      0,
      ' ',
      title ?? '',
      body ?? '',
      [],
      {},
      -1,
    ));
    await client.close();
  }

  @override
  Future<void> cancel(int id) async {
    final ids = auroraIDs[id] ?? [];
    if (ids.isNotEmpty) {
      final client = DBusClient.session();
      final object = OrgFreedesktopNotifications(
          client,
          'org.freedesktop.Notifications',
          DBusObjectPath('/org/freedesktop/Notifications'));
      for (final auroraID in ids) {
        await object.callCloseNotification(auroraID);
      }
      ids.remove(id);
      await client.close();
    }
  }
}
