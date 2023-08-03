// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:dbus/dbus.dart';

/// Signal data for ru.omp.deviceinfo.Features.cameraEnabledChanged.
class RuOmpDeviceinfoFeaturescameraEnabledChanged extends DBusSignal {
  bool get enabled => values[0].asBoolean();

  RuOmpDeviceinfoFeaturescameraEnabledChanged(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

class RuOmpDeviceinfoFeatures extends DBusRemoteObject {
  /// Stream of ru.omp.deviceinfo.Features.cameraEnabledChanged signals.
  late final Stream<RuOmpDeviceinfoFeaturescameraEnabledChanged>
      cameraEnabledChanged;

  RuOmpDeviceinfoFeatures(
      DBusClient client, String destination, DBusObjectPath path)
      : super(client, name: destination, path: path) {
    cameraEnabledChanged = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'ru.omp.deviceinfo.Features',
            name: 'cameraEnabledChanged',
            signature: DBusSignature('b'))
        .asBroadcastStream()
        .map((signal) => RuOmpDeviceinfoFeaturescameraEnabledChanged(signal));
  }

  /// Invokes ru.omp.deviceinfo.Features.hasGNSS()
  Future<bool> callhasGNSS(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('ru.omp.deviceinfo.Features', 'hasGNSS', [],
        replySignature: DBusSignature('b'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asBoolean();
  }

  /// Invokes ru.omp.deviceinfo.Features.hasNFC()
  Future<bool> callhasNFC(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('ru.omp.deviceinfo.Features', 'hasNFC', [],
        replySignature: DBusSignature('b'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asBoolean();
  }

  /// Invokes ru.omp.deviceinfo.Features.hasBluetooth()
  Future<bool> callhasBluetooth(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'hasBluetooth', [],
        replySignature: DBusSignature('b'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asBoolean();
  }

  /// Invokes ru.omp.deviceinfo.Features.hasWlan()
  Future<bool> callhasWlan(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('ru.omp.deviceinfo.Features', 'hasWlan', [],
        replySignature: DBusSignature('b'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asBoolean();
  }

  /// Invokes ru.omp.deviceinfo.Features.getMaxCpuClockSpeed()
  Future<int> callgetMaxCpuClockSpeed(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getMaxCpuClockSpeed', [],
        replySignature: DBusSignature('u'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUint32();
  }

  /// Invokes ru.omp.deviceinfo.Features.getNumberCpuCores()
  Future<int> callgetNumberCpuCores(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getNumberCpuCores', [],
        replySignature: DBusSignature('u'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUint32();
  }

  /// Invokes ru.omp.deviceinfo.Features.getCpuModel()
  Future<String> callgetCpuModel(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getCpuModel', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes ru.omp.deviceinfo.Features.getMaxCpuCoresClockSpeed()
  Future<List<DBusValue>> callgetMaxCpuCoresClockSpeed(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getMaxCpuCoresClockSpeed', [],
        replySignature: DBusSignature('av'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asVariantArray().toList();
  }

  /// Invokes ru.omp.deviceinfo.Features.getBatteryChargePercentage()
  Future<int> callgetBatteryChargePercentage(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getBatteryChargePercentage', [],
        replySignature: DBusSignature('u'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUint32();
  }

  /// Invokes ru.omp.deviceinfo.Features.getMainCameraResolution()
  Future<double> callgetMainCameraResolution(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getMainCameraResolution', [],
        replySignature: DBusSignature('d'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asDouble();
  }

  /// Invokes ru.omp.deviceinfo.Features.getFrontalCameraResolution()
  Future<double> callgetFrontalCameraResolution(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getFrontalCameraResolution', [],
        replySignature: DBusSignature('d'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asDouble();
  }

  /// Invokes ru.omp.deviceinfo.Features.getRamTotalSize()
  Future<int> callgetRamTotalSize(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getRamTotalSize', [],
        replySignature: DBusSignature('t'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUint64();
  }

  /// Invokes ru.omp.deviceinfo.Features.getRamFreeSize()
  Future<int> callgetRamFreeSize(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getRamFreeSize', [],
        replySignature: DBusSignature('t'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asUint64();
  }

  /// Invokes ru.omp.deviceinfo.Features.getScreenResolution()
  Future<String> callgetScreenResolution(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getScreenResolution', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes ru.omp.deviceinfo.Features.getOsVersion()
  Future<String> callgetOsVersion(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getOsVersion', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes ru.omp.deviceinfo.Features.getDeviceModel()
  Future<String> callgetDeviceModel(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getDeviceModel', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }

  /// Invokes ru.omp.deviceinfo.Features.getSerialNumber()
  Future<String> callgetSerialNumber(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Features', 'getSerialNumber', [],
        replySignature: DBusSignature('s'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asString();
  }
}
