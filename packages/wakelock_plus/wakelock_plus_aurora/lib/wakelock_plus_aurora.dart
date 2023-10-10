// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'dart:async';

import 'package:dbus/dbus.dart';
import 'package:wakelock_plus_platform_interface/wakelock_plus_platform_interface.dart';
import 'com_nokia_mce_request.dart';

class WakelockPlusAurora extends WakelockPlusPlatformInterface {
  bool _enable = false;
  Timer? _timer;

  static void registerWith() {
    WakelockPlusPlatformInterface.instance = WakelockPlusAurora();
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
