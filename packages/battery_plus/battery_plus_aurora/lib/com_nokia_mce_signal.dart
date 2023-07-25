/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:dbus/dbus.dart';

/// Signal data for com.nokia.mce.signal.battery_status_ind.
class ComNokiaMceSignalbattery_status_ind extends DBusSignal {
  String get battery_status => values[0].asString();

  ComNokiaMceSignalbattery_status_ind(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

/// Signal data for com.nokia.mce.signal.charger_state_ind.
class ComNokiaMceSignalcharger_state_ind extends DBusSignal {
  String get charger_state => values[0].asString();

  ComNokiaMceSignalcharger_state_ind(DBusSignal signal)
      : super(
            sender: signal.sender,
            path: signal.path,
            interface: signal.interface,
            name: signal.name,
            values: signal.values);
}

class ComNokiaMceSignal extends DBusRemoteObject {
  /// Stream of com.nokia.mce.signal.battery_status_ind signals.
  late final Stream<ComNokiaMceSignalbattery_status_ind> battery_status_ind;

  /// Stream of com.nokia.mce.signal.charger_state_ind signals.
  late final Stream<ComNokiaMceSignalcharger_state_ind> charger_state_ind;

  ComNokiaMceSignal(DBusClient client, String destination,
      {DBusObjectPath path =
          const DBusObjectPath.unchecked('/com/nokia/mce/signal')})
      : super(client, name: destination, path: path) {
    battery_status_ind = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'com.nokia.mce.signal',
            name: 'battery_status_ind',
            signature: DBusSignature('s'))
        .asBroadcastStream()
        .map((signal) => ComNokiaMceSignalbattery_status_ind(signal));

    charger_state_ind = DBusRemoteObjectSignalStream(
            object: this,
            interface: 'com.nokia.mce.signal',
            name: 'charger_state_ind',
            signature: DBusSignature('s'))
        .asBroadcastStream()
        .map((signal) => ComNokiaMceSignalcharger_state_ind(signal));
  }
}
