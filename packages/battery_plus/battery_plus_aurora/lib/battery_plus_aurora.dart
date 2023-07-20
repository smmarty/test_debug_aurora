/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:battery_plus_aurora/com_nokia_mce_request.dart';
import 'package:battery_plus_aurora/com_nokia_mce_signal.dart';
import 'package:dbus/dbus.dart';
import 'package:battery_plus_platform_interface/battery_plus_platform_interface.dart';
import 'dart:async' show Stream;
import 'package:async/async.dart' show StreamGroup;

class BatteryPlusAurora extends BatteryPlatform {
  /// Register this dart class as the platform implementation for aurora
  static void registerWith() {
    BatteryPlatform.instance = BatteryPlusAurora();
  }

  /// Returns the current battery level in percent.
  @override
  Future<int> get batteryLevel async {
    final client = DBusClient.system();
    final request = ComNokiaMceRequest(client, 'com.nokia.mce');
    final level = await request.callget_battery_level();
    await client.close();
    return level;
  }

  /// Returns true if the device is on battery save mode
  @override
  Future<bool> get isInBatterySaveMode async {
    final client = DBusClient.system();
    final request = ComNokiaMceRequest(client, 'com.nokia.mce');
    final state = await request.callget_psm_state();
    await client.close();
    return state;
  }

  /// Returns the current battery state in percent.
  @override
  Future<BatteryState> get batteryState async {
    final client = DBusClient.system();
    final request = ComNokiaMceRequest(client, 'com.nokia.mce');

    final level = await request.callget_battery_level();
    final status = await request.callget_charger_state();

    await client.close();

    if (level == 100) {
      return BatteryState.full;
    } else if (status == 'on') {
      return BatteryState.charging;
    } else {
      return BatteryState.discharging;
    }
  }

  /// Returns a Stream of BatteryState changes.
  @override
  Stream<BatteryState> get onBatteryStateChanged async* {
    final client = DBusClient.system();
    final signal = ComNokiaMceSignal(client, 'com.nokia.mce');
    final request = ComNokiaMceRequest(client, 'com.nokia.mce');

    var steam = StreamGroup.merge([
      signal.battery_status_ind,
      signal.charger_state_ind,
    ]);

    await for (final event in steam) {
      if (event.name == 'battery_status_ind') {
        if (event.values.first.toNative() == 'full') {
          yield BatteryState.full;
        }
      } else {
        if (event.values.first.toNative() == 'on') {
          yield BatteryState.charging;
          final level = await request.callget_battery_level();
          if (level == 100) {
            yield BatteryState.full;
          }
        } else {
          yield BatteryState.discharging;
        }
      }
    }
    await client.close();
  }
}
