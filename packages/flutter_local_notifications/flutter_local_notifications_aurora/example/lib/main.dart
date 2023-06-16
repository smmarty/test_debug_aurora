/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final notificationID = 1;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showNotification() async {
    await flutterLocalNotificationsPlugin.show(
      notificationID,
      "Title notification",
      "My long body text notification",
      null,
    );
  }

  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(notificationID);
  }

  @override
  Widget build(BuildContext context) {
    const textStyleWhite = TextStyle(fontSize: 18, color: Colors.white);
    const spaceMedium = SizedBox(height: 20);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example flutter_local_notifications'),
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
                      'Demo application demonstration implementation of flutter_local_notifications',
                      style: textStyleWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: _showNotification,
                    child: const Text('Show notification'),
                  ),

                  spaceMedium,

                  ElevatedButton(
                    onPressed: _cancelNotification,
                    child: const Text('Cancel notification'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
