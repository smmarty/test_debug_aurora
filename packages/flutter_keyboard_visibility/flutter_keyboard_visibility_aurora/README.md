# flutter_keyboard_visibility_aurora

The Aurora implementation of [flutter_keyboard_visibility](https://pub.dev/packages/flutter_keyboard_visibility).

## Usage
This package is not an _endorsed_ implementation of `flutter_keyboard_visibility`.
Therefore, you have to include `flutter_local_notifications_aurora` alongside `flutter_keyboard_visibility` as dependencies in your `pubspec.yaml` file.

**pubspec.yaml**

```yaml
dependencies:
  flutter_keyboard_visibility: 5.4.1
  flutter_keyboard_visibility_aurora:
    path: # path to folder with plugin
```

***.dart**

```dart
/// Default plugin component
final _controller = KeyboardVisibilityController();

/// Custom platform component with keyboard height
final _controllerAurora = FlutterKeyboardVisibilityAurora();

/// Stream change visibility
Stream<bool> onChangeKeyboard() async* {
  yield _controller.isVisible;
  
  await for (final state in _controller.onChange) {
    yield state;
  }
}

/// Stream change height
Stream<int> onChangeKeyboardHeight() async* {
  yield await _controllerAurora.height;
  
  await for (final state in _controllerAurora.onChangeHeight) {
    yield state;
  }
}
```

