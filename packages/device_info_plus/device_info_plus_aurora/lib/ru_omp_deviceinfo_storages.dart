// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:dbus/dbus.dart';

/// Signal data for ru.omp.deviceinfo.Storages.externalStorageChanged.
class RuOmpDeviceinfoStoragesexternalStorageChanged extends DBusSignal {
  Map<String, DBusValue> get updatedStorage => values[0].asStringVariantDict();

  RuOmpDeviceinfoStoragesexternalStorageChanged(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

class RuOmpDeviceinfoStorages extends DBusRemoteObject {
  /// Stream of ru.omp.deviceinfo.Storages.externalStorageChanged signals.
  late final Stream<RuOmpDeviceinfoStoragesexternalStorageChanged>
      externalStorageChanged;

  RuOmpDeviceinfoStorages(
      DBusClient client, String destination, DBusObjectPath path)
      : super(client, name: destination, path: path) {
    externalStorageChanged = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'ru.omp.deviceinfo.Storages',
            name: 'externalStorageChanged',
            signature: DBusSignature('a{sv}'))
        .asBroadcastStream()
        .map((signal) => RuOmpDeviceinfoStoragesexternalStorageChanged(signal));
  }

  /// Invokes ru.omp.deviceinfo.Storages.getInternalStorageInfo()
  Future<Map<String, DBusValue>> callgetInternalStorageInfo(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Storages', 'getInternalStorageInfo', [],
        replySignature: DBusSignature('a{sv}'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asStringVariantDict();
  }

  /// Invokes ru.omp.deviceinfo.Storages.getInternalUserPartitionInfo()
  Future<Map<String, DBusValue>> callgetInternalUserPartitionInfo(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Storages', 'getInternalUserPartitionInfo', [],
        replySignature: DBusSignature('a{sv}'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asStringVariantDict();
  }

  /// Invokes ru.omp.deviceinfo.Storages.getExternalStorageInfo()
  Future<Map<String, DBusValue>> callgetExternalStorageInfo(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod(
        'ru.omp.deviceinfo.Storages', 'getExternalStorageInfo', [],
        replySignature: DBusSignature('a{sv}'),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asStringVariantDict();
  }
}
