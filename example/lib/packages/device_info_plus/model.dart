// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus_aurora/aurora_device_info.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [DeviceInfoPlusPage]
class DeviceInfoPlusModel extends Model {
  /// Get [ScopedModel]
  static DeviceInfoPlusModel of(BuildContext context) =>
      ScopedModel.of<DeviceInfoPlusModel>(context);

  final _deviceInfoPlugin = DeviceInfoPlugin();

  /// Get Aurora info
  Future<AuroraDeviceInfo> get _deviceInfo async =>
      await _deviceInfoPlugin.linuxInfo as AuroraDeviceInfo;

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Get ID name device
  Future<String?> getID() async {
    try {
      return (await _deviceInfo).id;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Device name
  Future<String?> getName() async {
    try {
      return (await _deviceInfo).name;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Version
  Future<String?> getVersion() async {
    try {
      return (await _deviceInfo).version;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Device full name
  Future<String?> getPrettyName() async {
    try {
      return (await _deviceInfo).prettyName;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Check has GNSS
  Future<bool?> hasGNSS() async {
    try {
      return (await _deviceInfo).hasGNSS;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Check has NFC
  Future<bool?> hasNFC() async {
    try {
      return (await _deviceInfo).hasNFC;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Check has Bluetooth
  Future<bool?> hasBluetooth() async {
    try {
      return (await _deviceInfo).hasBluetooth;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Check has Wlan
  Future<bool?> hasWlan() async {
    try {
      return (await _deviceInfo).hasWlan;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Max CPU clock speed
  Future<int?> getMaxCpuClockSpeed() async {
    try {
      return (await _deviceInfo).maxCpuClockSpeed;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Number CPU cores
  Future<int?> getNumberCpuCores() async {
    try {
      return (await _deviceInfo).numberCpuCores;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Get battery level in percent 0-100
  Future<int?> getBatteryChargePercentage() async {
    try {
      return (await _deviceInfo).batteryChargePercentage;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Camera resolution
  Future<double?> getMainCameraResolution() async {
    try {
      return (await _deviceInfo).mainCameraResolution;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Frontal camera resolution
  Future<double?> getFrontalCameraResolution() async {
    try {
      return (await _deviceInfo).frontalCameraResolution;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// RAM total size
  Future<int?> getRamTotalSize() async {
    try {
      return (await _deviceInfo).ramTotalSize;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// RAM free size
  Future<int?> getRamFreeSize() async {
    try {
      return (await _deviceInfo).ramFreeSize;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Screen resolution
  Future<String?> getScreenResolution() async {
    try {
      return (await _deviceInfo).screenResolution;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Version @todo
  Future<String?> getOsVersion() async {
    try {
      return (await _deviceInfo).osVersion;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Device model
  Future<String?> getDeviceModel() async {
    try {
      return (await _deviceInfo).deviceModel;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Get map with info about external storage
  Future<Map<String, dynamic>?> getExternalStorage() async {
    try {
      return (await _deviceInfo).externalStorage;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Get map with info about internal storage
  Future<Map<String, dynamic>?> getInternalStorage() async {
    try {
      return (await _deviceInfo).internalStorage;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Get map with info about SIM cards
  Future<List<Map<String, dynamic>>?> getSimCards() async {
    try {
      return (await _deviceInfo).simCards;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }
}
