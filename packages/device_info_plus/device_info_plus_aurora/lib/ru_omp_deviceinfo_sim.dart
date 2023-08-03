// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:dbus/dbus.dart';

/// Signal data for ru.omp.deviceinfo.SIM.simCardsEnabledChanged.
class RuOmpDeviceinfoSIMsimCardsEnabledChanged extends DBusSignal {
  List<Map<String, DBusValue>> get updatedSimCards =>
      values[0].asArray().map((child) => child.asStringVariantDict()).toList();

  RuOmpDeviceinfoSIMsimCardsEnabledChanged(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for ru.omp.deviceinfo.SIM.preferredDataTransferSimChanged.
class RuOmpDeviceinfoSIMpreferredDataTransferSimChanged extends DBusSignal {
  List<Map<String, DBusValue>> get updatedSimCards =>
      values[0].asArray().map((child) => child.asStringVariantDict()).toList();

  RuOmpDeviceinfoSIMpreferredDataTransferSimChanged(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for ru.omp.deviceinfo.SIM.preferredVoiceCallSimChanged.
class RuOmpDeviceinfoSIMpreferredVoiceCallSimChanged extends DBusSignal {
  List<Map<String, DBusValue>> get updatedSimCards =>
      values[0].asArray().map((child) => child.asStringVariantDict()).toList();

  RuOmpDeviceinfoSIMpreferredVoiceCallSimChanged(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

class RuOmpDeviceinfoSIM extends DBusRemoteObject {
  /// Stream of ru.omp.deviceinfo.SIM.simCardsEnabledChanged signals.
  late final Stream<RuOmpDeviceinfoSIMsimCardsEnabledChanged>
      simCardsEnabledChanged;

  /// Stream of ru.omp.deviceinfo.SIM.preferredDataTransferSimChanged signals.
  late final Stream<RuOmpDeviceinfoSIMpreferredDataTransferSimChanged>
      preferredDataTransferSimChanged;

  /// Stream of ru.omp.deviceinfo.SIM.preferredVoiceCallSimChanged signals.
  late final Stream<RuOmpDeviceinfoSIMpreferredVoiceCallSimChanged>
      preferredVoiceCallSimChanged;

  RuOmpDeviceinfoSIM(DBusClient client, String destination, DBusObjectPath path)
      : super(client, name: destination, path: path) {
    simCardsEnabledChanged = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'ru.omp.deviceinfo.SIM',
            name: 'simCardsEnabledChanged',
            signature: DBusSignature('aa{sv}'))
        .asBroadcastStream()
        .map((signal) => RuOmpDeviceinfoSIMsimCardsEnabledChanged(signal));

    preferredDataTransferSimChanged = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'ru.omp.deviceinfo.SIM',
            name: 'preferredDataTransferSimChanged',
            signature: DBusSignature('aa{sv}'))
        .asBroadcastStream()
        .map((signal) =>
            RuOmpDeviceinfoSIMpreferredDataTransferSimChanged(signal));

    preferredVoiceCallSimChanged = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'ru.omp.deviceinfo.SIM',
            name: 'preferredVoiceCallSimChanged',
            signature: DBusSignature('aa{sv}'))
        .asBroadcastStream()
        .map(
            (signal) => RuOmpDeviceinfoSIMpreferredVoiceCallSimChanged(signal));
  }

  /// Invokes ru.omp.deviceinfo.SIM.getSimCardsInfo()
  Future<List<Map<String, DBusValue>>> callgetSimCardsInfo(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.SIM', 'getSimCardsInfo', [],
        replySignature: DBusSignature('aa{sv}'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0]
        .asArray()
        .map((child) => child.asStringVariantDict())
        .toList();
  }
}
