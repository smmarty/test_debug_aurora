/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:device_info_plus_aurora/aurora_device_info.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _error;
  String? _id;
  String? _name;
  String? _version;
  String? _prettyName;
  bool? _hasGNSS;
  bool? _hasNFC;
  bool? _hasBluetooth;
  bool? _hasWlan;
  int? _maxCpuClockSpeed;
  int? _numberCpuCores;
  int? _batteryChargePercentage;
  double? _mainCameraResolution;
  double? _frontalCameraResolution;
  int? _ramTotalSize;
  int? _ramFreeSize;
  String? _screenResolution;
  String? _osVersion;
  String? _deviceModel;
  Map<String, dynamic>? _externalStorage;
  Map<String, dynamic>? _internalStorage;
  List<Map<String, dynamic>>? _simCards;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    try {
      final deviceInfo = await deviceInfoPlugin.linuxInfo as AuroraDeviceInfo;
      setState(() {
        _id = deviceInfo.id;
        _name = deviceInfo.name;
        _version = deviceInfo.version;
        _prettyName = deviceInfo.prettyName;
        _hasGNSS = deviceInfo.hasGNSS;
        _hasNFC = deviceInfo.hasNFC;
        _hasBluetooth = deviceInfo.hasBluetooth;
        _hasWlan = deviceInfo.hasWlan;
        _maxCpuClockSpeed = deviceInfo.maxCpuClockSpeed;
        _numberCpuCores = deviceInfo.numberCpuCores;
        _batteryChargePercentage = deviceInfo.batteryChargePercentage;
        _mainCameraResolution = deviceInfo.mainCameraResolution;
        _frontalCameraResolution = deviceInfo.frontalCameraResolution;
        _ramTotalSize = deviceInfo.ramTotalSize;
        _ramFreeSize = deviceInfo.ramFreeSize;
        _screenResolution = deviceInfo.screenResolution;
        _osVersion = deviceInfo.osVersion;
        _deviceModel = deviceInfo.deviceModel;
        _externalStorage = deviceInfo.externalStorage;
        _internalStorage = deviceInfo.internalStorage;
        _simCards = deviceInfo.simCards;
      });
    } on Exception catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyleWhite = TextStyle(fontSize: 18, color: Colors.white);
    const textStyleTitle = TextStyle(fontSize: 20, color: Colors.black);
    const textStylePath = TextStyle(fontSize: 18, color: Colors.black54);

    const spaceMedium = SizedBox(height: 20);
    const spaceSmall = SizedBox(height: 10);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example device_info_plus'),
        ),
        body: Stack(
          children: [
            // Error message
            Visibility(
              visible: _error != null,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text(
                      _error ?? '',
                      style: textStyleWhite,
                    ),
                  ),
                ),
              ),
            ),
            // List directories path
            Visibility(
              visible: _error == null,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      children: [
                        // Info
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: const Text(
                            'Demo application demonstration implementation of device_info_plus',
                            style: textStyleWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Text(
                          'ID',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _id.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Name',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _name.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Version',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _version.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Pretty Name',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _prettyName.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Has GNSS',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _hasGNSS.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Has NFC',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _hasNFC.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Has Bluetooth',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _hasBluetooth.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Has Wlan',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _hasWlan.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Max Cpu Clock Speed',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _maxCpuClockSpeed.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Number Cpu Cores',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _numberCpuCores.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Battery Charge Percentage',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _batteryChargePercentage.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Main Camera Resolution',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _mainCameraResolution.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Frontal Camera Resolution',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _frontalCameraResolution.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Ram Total Size',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _ramTotalSize.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Ram Free Size',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _ramFreeSize.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Screen Resolution',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _screenResolution.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'OS Version',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _osVersion.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Device Model',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _deviceModel.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'External Storage Info',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _externalStorage.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Internal Storage Info',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _internalStorage.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'SIM Cards Info',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _simCards.toString(),
                          style: textStylePath,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
