import 'package:flutter/services.dart';

import 'flutter_keyboard_visibility_aurora_platform_interface.dart';

/// An implementation of [FlutterKeyboardVisibilityAuroraPlatform] that uses method channels.
class MethodChannelFlutterKeyboardVisibilityAurora
    extends FlutterKeyboardVisibilityAuroraPlatform {
  final methodChannel =
      const MethodChannel('flutter_keyboard_visibility_aurora');

  @override
  Future<double> getKeyboardHeight() async {
    return await methodChannel.invokeMethod<double>('getKeyboardHeight') ?? 0.0;
  }

  @override
  Stream<bool> onChangeVisibility() async* {
    await for (final event
        in const EventChannel('flutter_keyboard_visibility_aurora_state')
            .receiveBroadcastStream()) {
      yield event == true;
    }
  }

  @override
  Stream<double> onChangeHeight() async* {
    await for (final event
        in const EventChannel('flutter_keyboard_visibility_aurora_height')
            .receiveBroadcastStream()) {
      yield event as double;
    }
  }
}
