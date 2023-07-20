/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_keyboard_visibility_aurora/flutter_keyboard_visibility_aurora.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart' show kIsAurora;

/// Model for [FlutterKeyboardVisibilityPage]
class FlutterKeyboardVisibilityModel extends Model {
  /// Get [ScopedModel]
  static FlutterKeyboardVisibilityModel of(BuildContext context) =>
      ScopedModel.of<FlutterKeyboardVisibilityModel>(context);

  final _controller = KeyboardVisibilityController();
  final _controllerAurora = FlutterKeyboardVisibilityAurora();

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Stream change visibility
  Stream<bool> onChangeKeyboard() async* {
    try {
      yield _controller.isVisible;
      await for (final state in _controller.onChange) {
        yield state;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Stream change height
  Stream<double> onChangeKeyboardHeight() async* {
    if (kIsAurora) {
      try {
        yield await _controllerAurora.height;
        await for (final state in _controllerAurora.onChangeHeight) {
          yield state;
        }
      } catch (e) {
        _error = e.toString();
        notifyListeners();
      }
    } else {
      yield 0;
    }
  }
}
