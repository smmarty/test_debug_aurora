/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _enableWakelock = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _toggleWakelock() async {
    final enableWakelock = !(await Wakelock.enabled);
    await Wakelock.toggle(enable: enableWakelock);
    setState(() {
      _enableWakelock = enableWakelock;
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyleWhite = TextStyle(fontSize: 18, color: Colors.white);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example wakelock'),
        ),
        body: SingleChildScrollView(
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: const Text(
                      'Demo application demonstration implementation of wakelock',
                      style: textStyleWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: _toggleWakelock,
                    child: Text('Toggle wakelock: $_enableWakelock'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
