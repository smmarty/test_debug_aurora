# sqflite_aurora

The Aurora OS implementation of [`sqflite`](https://pub.dev/packages/sqflite).

## Usage

This package is not an endorsed implementation of `sqflite`.
Therefore, you have to include `sqflite_aurora` alongside `sqflite` as dependencies in your `pubspec.yaml` file.

**pubspec.yaml**

```yaml
dependencies:
  sqflite: ^2.2.6
  sqflite_aurora:
    path: # path to folder with plugin
```

***.dart**

```dart
import 'package:sqflite/sqflite.dart';
```
