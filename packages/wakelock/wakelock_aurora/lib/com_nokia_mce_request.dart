// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:dbus/dbus.dart';

class ComNokiaMceRequest extends DBusRemoteObject {
  ComNokiaMceRequest(DBusClient client, String destination,
      {DBusObjectPath path =
          const DBusObjectPath.unchecked('/com/nokia/mce/request')})
      : super(client, name: destination, path: path);

  /// Invokes com.nokia.mce.request.req_display_blanking_pause()
  Future<void> callreq_display_blanking_pause(
      {bool noAutoStart = false,
      bool allowInteractiveAuthorization = false}) async {
    await callMethod('com.nokia.mce.request', 'req_display_blanking_pause', [],
        replySignature: DBusSignature(''),
        noAutoStart: noAutoStart,
        allowInteractiveAuthorization: allowInteractiveAuthorization);
  }
}
