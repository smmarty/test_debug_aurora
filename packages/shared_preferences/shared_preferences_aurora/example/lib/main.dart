/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? _counter;
  bool? _repeat;
  double? _decimal;
  String? _action;
  List<String>? _items;
  String? _error;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      SharedPreferences.setPrefix("my_prefix.");

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save an integer value to 'counter' key.
      await prefs.setInt('counter', 10);
      // Save an boolean value to 'repeat' key.
      await prefs.setBool('repeat', true);
      // Save an double value to 'decimal' key.
      await prefs.setDouble('decimal', 1.5);
      // Save an String value to 'action' key.
      await prefs.setString('action', 'Start');
      // Save an list of strings to 'items' key.
      await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

      // Try reading data from the 'counter' key. If it doesn't exist, returns null.
      final int? counter = prefs.getInt('counter');
      // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
      final bool? repeat = prefs.getBool('repeat');
      // Try reading data from the 'decimal' key. If it doesn't exist, returns null.
      final double? decimal = prefs.getDouble('decimal');
      // Try reading data from the 'action' key. If it doesn't exist, returns null.
      final String? action = prefs.getString('action');
      // Try reading data from the 'items' key. If it doesn't exist, returns null.
      final List<String>? items = prefs.getStringList('items');

      setState(() {
        _counter = counter;
        _repeat = repeat;
        _decimal = decimal;
        _action = action;
        _items = items;
      });
    } on PlatformException {
      setState(() {
        _error = 'Platform exception';
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
          title: const Text('Example shared_preferences'),
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
                            'Demo application demonstration implementation of shared_preferences',
                            style: textStyleWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Text(
                          'Counter / int',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _counter.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Repeat / bool',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _repeat.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Decimal / double',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _decimal.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Action / String',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _action.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'Items / String List',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _items.toString(),
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
