// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus_aurora/events/als_event.dart';
import 'package:sensors_plus_aurora/events/compass_event.dart';
import 'package:sensors_plus_aurora/events/orientation_event.dart';
import 'package:sensors_plus_aurora/events/proximity_event.dart';
import 'package:sensors_plus_aurora/events/tap_event.dart';
import 'package:sensors_plus_platform_interface/sensors_plus_platform_interface.dart';

import 'sensors_plus_aurora_platform_interface.dart';

/// An implementation of [SensorsPlusAuroraPlatform] that uses method channels.
class MethodChannelSensorsPlusAurora extends SensorsPlusAuroraPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sensors_plus_aurora');

  List<int> _loadData(dynamic data, String key) {
    if (data == null) {
      throw "Failed to load sensor '$key'";
    }

    return (data as List<Object?>).map((e) => int.parse(e.toString())).toList();
  }

  @override
  Stream<OrientationEvent> onChangeOrientation() async* {
    await for (final data
        in const EventChannel('sensors_plus_aurora_orientationsensor')
            .receiveBroadcastStream()) {
      switch (_loadData(data, 'orientationsensor')[0]) {
        case 1:
          yield OrientationEvent.rightUp;
          break;
        case 2:
          yield OrientationEvent.leftUp;
          break;
        case 3:
          yield OrientationEvent.topDown;
          break;
        case 4:
          yield OrientationEvent.topUp;
          break;
        case 5:
          yield OrientationEvent.faceDown;
          break;
        case 6:
          yield OrientationEvent.faceUp;
          break;
        default:
          yield OrientationEvent.undefined;
      }
    }
  }

  @override
  Stream<AccelerometerEvent> onChangeAccelerometer() async* {
    await for (final data
        in const EventChannel('sensors_plus_aurora_accelerometersensor')
            .receiveBroadcastStream()) {
      final result = _loadData(data, 'accelerometersensor');
      yield AccelerometerEvent(
        result[0].toDouble(),
        result[1].toDouble(),
        result[2].toDouble(),
      );
    }
  }

  @override
  Stream<CompassEvent> onChangeCompass() async* {
    await for (final data
        in const EventChannel('sensors_plus_aurora_compasssensor')
            .receiveBroadcastStream()) {
      final result = _loadData(data, 'compasssensor');
      yield CompassEvent(
        result[0],
        result[1],
      );
    }
  }

  @override
  Stream<TapEvent> onChangeTap() async* {
    await for (final data in const EventChannel('sensors_plus_aurora_tapsensor')
        .receiveBroadcastStream()) {
      final result = _loadData(data, 'tapsensor');
      yield TapEvent(
        TapDirection.values[result[0]],
        TapType.values[result[1]],
      );
    }
  }

  @override
  Stream<ALSEvent> onChangeALS() async* {
    await for (final data in const EventChannel('sensors_plus_aurora_alssensor')
        .receiveBroadcastStream()) {
      final result = _loadData(data, 'alssensor');
      yield ALSEvent(
        result[0],
      );
    }
  }

  @override
  Stream<ProximityEvent> onChangeProximity() async* {
    await for (final data
        in const EventChannel('sensors_plus_aurora_proximitysensor')
            .receiveBroadcastStream()) {
      final result = _loadData(data, 'proximitysensor');
      yield ProximityEvent(
        result[0] == 1,
      );
    }
  }

  @override
  Stream<GyroscopeEvent> onChangeRotation() async* {
    await for (final data
        in const EventChannel('sensors_plus_aurora_rotationsensor')
            .receiveBroadcastStream()) {
      final result = _loadData(data, 'rotationsensor');
      yield GyroscopeEvent(
        result[0].toDouble(),
        result[1].toDouble(),
        result[2].toDouble(),
      );
    }
  }

  @override
  Stream<MagnetometerEvent> onChangeMagnetometer() async* {
    await for (final data
        in const EventChannel('sensors_plus_aurora_magnetometersensor')
            .receiveBroadcastStream()) {
      final result = _loadData(data, 'magnetometersensor');
      yield MagnetometerEvent(
        result[0].toDouble(),
        result[1].toDouble(),
        result[2].toDouble(),
      );
    }
  }
}
