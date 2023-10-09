# sqflite_aurora

The Aurora OS implementation of [`sqflite`](https://pub.dev/packages/sqflite).

## Usage

This package is not an endorsed implementation of `sqflite`.
Therefore, you have to include `sqflite_aurora` alongside `sqflite` as dependencies in your `pubspec.yaml` file.

**pubspec.yaml**

```yaml
dependencies:
  sqflite: ^2.3.0
  sqflite_aurora:
    git:
      url: https://gitlab.com/omprussia/flutter/flutter-plugins.git
      ref: master
      path: packages/sqflite/sqflite_aurora
```

***.dart**

```dart
import 'package:sqflite/sqflite.dart';
```
