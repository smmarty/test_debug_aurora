// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:device_info_plus/device_info_plus.dart';

class AuroraDeviceInfo implements LinuxDeviceInfo {
  /// Constructs a AuroraDeviceInfo.
  AuroraDeviceInfo({
    required this.hasGNSS,
    required this.hasNFC,
    required this.hasBluetooth,
    required this.hasWlan,
    required this.maxCpuClockSpeed,
    required this.numberCpuCores,
    required this.batteryChargePercentage,
    required this.mainCameraResolution,
    required this.frontalCameraResolution,
    required this.ramTotalSize,
    required this.ramFreeSize,
    required this.screenResolution,
    required this.osVersion,
    required this.deviceModel,
    required this.externalStorage,
    required this.internalStorage,
    required this.simCards,
  });

  @override
  String get id => 'aurora';

  @override
  String get name => osVersion.split(' ').first;

  @override
  String? get version => osVersion.split(' ').last;

  @override
  String get prettyName => osVersion;

  final bool hasGNSS;
  final bool hasNFC;
  final bool hasBluetooth;
  final bool hasWlan;
  final int maxCpuClockSpeed;
  final int numberCpuCores;
  final int batteryChargePercentage;
  final double mainCameraResolution;
  final double frontalCameraResolution;
  final int ramTotalSize;
  final int ramFreeSize;
  final String screenResolution;
  final String osVersion;
  final String deviceModel;
  final Map<String, dynamic> externalStorage;
  final Map<String, dynamic> internalStorage;
  final List<Map<String, dynamic>> simCards;

  @override
  Map<String, dynamic> get data => {
        'id': id,
        'name': name,
        'version': version,
        'prettyName': prettyName,
        'hasGNSS': hasGNSS,
        'hasNFC': hasNFC,
        'hasBluetooth': hasBluetooth,
        'hasWlan': hasWlan,
        'maxCpuClockSpeed': maxCpuClockSpeed,
        'numberCpuCores': numberCpuCores,
        'batteryChargePercentage': batteryChargePercentage,
        'mainCameraResolution': mainCameraResolution,
        'frontalCameraResolution': frontalCameraResolution,
        'ramTotalSize': ramTotalSize,
        'ramFreeSize': ramFreeSize,
        'screenResolution': screenResolution,
        'osVersion': osVersion,
        'deviceModel': deviceModel,
        'externalStorage': externalStorage,
        'internalStorage': internalStorage,
        'simCards': simCards,
      };

  @override
  String? get buildId => null;

  @override
  List<String>? get idLike => null;

  @override
  String? get machineId => null;

  @override
  String? get variant => null;

  @override
  String? get variantId => null;

  @override
  String? get versionCodename => null;

  @override
  String? get versionId => null;

  @Deprecated('Use [data] getter instead')
  @override
  Map<String, dynamic> toMap() {
    return data;
  }
}
