/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_aurora/flutter_secure_storage_aurora.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterSecureStorage = const FlutterSecureStorage();
  String? _error;
  String? _data;
  String? _all;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      // https://pub.dev/packages/encrypt
      // Encrypter(AES(key))
      // secure-random --length 16 --base 16
      // You can generate a secret key based on user data, as an example of a hash pincode
      FlutterSecureStorageAurora.setSecret('5872747ed1ceda363808efb8b2b18b20');

      const key = 'my_key';
      const data = 'Something secret';

      // Write value
      await _flutterSecureStorage.write(key: key, value: data);

      // Read value
      String? value = await _flutterSecureStorage.read(key: key);

      // Read all values
      Map<String, String> allValues = await _flutterSecureStorage.readAll();

      setState(() {
        _data = value;
        _all = allValues.toString();
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
          title: const Text('Example flutter_secure_storage'),
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
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: const Text(
                            'Demo application demonstration implementation of flutter_secure_storage',
                            style: textStyleWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Text(
                          'After write/read secret data',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _data.toString(),
                          style: textStylePath,
                        ),

                        spaceMedium,
                        const Text(
                          'All data',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _all.toString(),
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
