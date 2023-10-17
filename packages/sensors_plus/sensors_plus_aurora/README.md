# sensors_plus_aurora

The Aurora implementation of [`sensors_plus`](https://pub.dev/packages/sensors_plus).

## Usage

This package is not an _endorsed_ implementation of `sensors_plus`.
Therefore, you have to include `sensors_plus_aurora` alongside `sensors_plus` as dependencies in your `pubspec.yaml` file.

**pubspec.yaml**

```yaml
dependencies:
  sensors_plus: ^4.0.0
  sensors_plus_aurora:
    git:
      url: https://gitlab.com/omprussia/flutter/flutter-plugins.git
      ref: master
      path: packages/sensors_plus/sensors_plus_aurora
```

## Features

- accelerometerEvents - A broadcast stream of events from the device accelerometer.
- gyroscopeEvents - A broadcast stream of events from the device gyroscope.
- magnetometerEvents - A broadcast stream of events from the device magnetometer.
- orientationEvents - A broadcast stream of events from the Aurora OS device orientation.
- compassEvents - A broadcast stream of events from the Aurora OS device compass.
- tapEvents - A broadcast stream of events from the Aurora OS device tap.
- alsEvents - A broadcast stream of events from the Aurora OS device ALS.
- proximityEvents - A broadcast stream of events from the Aurora OS device proximity.

***.desktop**

```desktop
Permissions=Sensors
```
***.spec**

```spec
BuildRequires: pkgconfig(sensord-qt5)
```

***.dart**

```dart
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sensors_plus_aurora/events/als_event.dart';
import 'package:sensors_plus_aurora/events/compass_event.dart';
import 'package:sensors_plus_aurora/events/orientation_event.dart';
import 'package:sensors_plus_aurora/events/proximity_event.dart';
import 'package:sensors_plus_aurora/events/tap_event.dart';
import 'package:sensors_plus_aurora/sensors_plus_aurora.dart';

/// Package sensors_plus
/// 
/// A broadcast stream of events from the device accelerometer.
accelerometerEvents.listen(
        (AccelerometerEvent event) {
      debugPrint(event.toString());
    },
    onError: (error) {
      debugPrint(error.toString());
    }
);

/// A broadcast stream of events from the device gyroscope.
gyroscopeEvents.listen(
        (GyroscopeEvent event) {
      debugPrint(event.toString());
    },
    onError: (error) {
      debugPrint(error.toString());
    }
);

/// A broadcast stream of events from the device magnetometer.
magnetometerEvents.listen(
        (MagnetometerEvent event) {
      debugPrint(event.toString());
    },
    onError: (error) {
      debugPrint(error.toString());
    }
);

/// Custom Aurora OS events
/// 
/// A broadcast stream of events from the Aurora OS device orientation.
orientationEvents?.listen(
  (OrientationEvent event) {
    debugPrint(event.toString());
  },
  onError: (error) {
    debugPrint(error.toString());
  }
);

/// A broadcast stream of events from the Aurora OS device compass.
compassEvents?.listen(
        (CompassEvent event) {
      debugPrint(event.toString());
    },
    onError: (error) {
      debugPrint(error.toString());
    }
);

/// A broadcast stream of events from the Aurora OS device tap.
tapEvents?.listen(
        (TapEvent event) {
      debugPrint(event.toString());
    },
    onError: (error) {
      debugPrint(error.toString());
    }
);

/// A broadcast stream of events from the Aurora OS device ALS.
alsEvents?.listen(
        (ALSEvent event) {
      debugPrint(event.toString());
    },
    onError: (error) {
      debugPrint(error.toString());
    }
);

/// A broadcast stream of events from the Aurora OS device proximity.
proximityEvents?.listen(
        (ProximityEvent event) {
      debugPrint(event.toString());
    },
    onError: (error) {
      debugPrint(error.toString());
    }
);
```
