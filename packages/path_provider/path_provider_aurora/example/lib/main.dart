/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_aurora/path_provider_aurora.dart';

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
  String? _pathApplicationSupportDirectory;
  String? _pathTempDirectory;
  String? _pathApplicationDocumentsPath;
  String? _pathDownloadsPath;
  String? _pathPictures;
  String? _pathMusic;
  String? _pathMovies;

  @override
  void initState() {
    super.initState();
    loadPathDirectory();
  }

  /// Asynchronous function receiving directory paths
  Future<void> loadPathDirectory() async {
    try {
      // Get directories
      Directory? applicationSupportDirectory =
          await getApplicationSupportDirectory();
      Directory? tempDirectory = await getTemporaryDirectory();
      Directory? pathApplicationDocumentsPath =
          await getApplicationDocumentsDirectory();
      Directory? pathDownloadsPath = await getDownloadsDirectory();
      List<Directory>? pathPictures =
          await getExternalStorageDirectories(type: StorageDirectory.pictures);
      List<Directory>? pathMusic =
          await getExternalStorageDirectories(type: StorageDirectory.music);
      List<Directory>? pathMovies =
          await getExternalStorageDirectories(type: StorageDirectory.movies);

      // Update state variable
      setState(() {
        _pathApplicationSupportDirectory = applicationSupportDirectory.path;
        _pathTempDirectory = tempDirectory.path;
        _pathApplicationDocumentsPath = pathApplicationDocumentsPath.path;
        _pathDownloadsPath = pathDownloadsPath?.path;
        _pathPictures = pathPictures?.first.path;
        _pathMusic = pathMusic?.first.path;
        _pathMovies = pathMovies?.first.path;
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
          title: const Text('Example path_provider'),
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
                            'Demo application demonstration implementation of path_provider',
                            style: textStyleWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // TempDirectory
                        const Text(
                          'ApplicationSupportDirectory',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _pathApplicationSupportDirectory ?? 'Not found.',
                          style: textStylePath,
                        ),

                        spaceMedium,
                        // TempDirectory
                        const Text(
                          'TempDirectory',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _pathTempDirectory ?? 'Not found.',
                          style: textStylePath,
                        ),
                        spaceMedium,

                        // ApplicationDocumentsPath
                        const Text(
                          'ApplicationDocumentsPath',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _pathApplicationDocumentsPath ?? 'Not found.',
                          style: textStylePath,
                        ),
                        spaceMedium,

                        // DownloadsPath
                        const Text(
                          'DownloadsPath',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _pathDownloadsPath ?? 'Not found.',
                          style: textStylePath,
                        ),
                        spaceMedium,

                        // Pictures
                        const Text(
                          'Pictures',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _pathPictures ?? 'Not found.',
                          style: textStylePath,
                        ),
                        spaceMedium,

                        // Music
                        const Text(
                          'Music',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _pathMusic ?? 'Not found.',
                          style: textStylePath,
                        ),
                        spaceMedium,

                        // Movies
                        const Text(
                          'Movies',
                          style: textStyleTitle,
                        ),
                        spaceSmall,
                        Text(
                          _pathMovies ?? 'Not found.',
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
