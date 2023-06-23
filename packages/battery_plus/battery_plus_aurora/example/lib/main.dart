/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:battery_plus/battery_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _battery = Battery();
  String? _error;
  int? _batteryLevel;
  String? _batteryState;
  bool? _isInBatterySaveMode;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      // Get current battery level
      final batteryLevel = await _battery.batteryLevel;
      // Get current battery state
      final batteryState = await _battery.batteryState;
      // Check is enable SaveMode
      final isInBatterySaveMode = await _battery.isInBatterySaveMode;

      // Be informed when the state (full, charging, discharging) changes
      _battery.onBatteryStateChanged.listen((BatteryState state) {
        debugPrint(state.toString());
      });

      setState(() {
        _batteryLevel = batteryLevel;
        _batteryState = batteryState.name;
        _isInBatterySaveMode = isInBatterySaveMode;
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
          title: const Text('Example battery_plus'),
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
                            'Demo application demonstration implementation of battery_plus',
                            style: textStyleWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Text(
                          'Battery Level',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          "$_batteryLevel%",
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Battery State',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _batteryState.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Is In Battery SaveMode',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _isInBatterySaveMode.toString(),
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
