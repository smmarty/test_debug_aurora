/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:wakelock_platform_interface/wakelock_platform_interface.dart';
import 'com_nokia_mce_request.dart';

class WakelockAurora extends WakelockPlatformInterface {
  bool _enable = false;
  Timer? _timer;

  static void registerWith() {
    WakelockPlatformInterface.instance = WakelockAurora();
  }

  @override
  Future<void> toggle({required bool enable}) async {
    if (_enable != enable) {
      _enable = enable;
      final client = DBusClient.system();
      final request = ComNokiaMceRequest(client, 'com.nokia.mce');
      if (_timer == null) {
        request.callreq_display_blanking_pause();
        _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
          request.callreq_display_blanking_pause();
        });
      } else {
        _timer?.cancel();
        _timer = null;
      }
      await client.close();
    }
  }

  @override
  Future<bool> get enabled async {
    return _enable;
  }
}
