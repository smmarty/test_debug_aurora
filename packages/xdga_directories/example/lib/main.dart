/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:xdga_directories/xdga_directories.dart' as xdga;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String appDataLocation;
  late String cacheLocation;
  late String documentsLocation;
  late String downloadLocation;
  late String musicLocation;
  late String picturesLocation;
  late String genericDataLocation;
  late String moviesLocation;

  @override
  void initState() {
    super.initState();
    // Get paths
    appDataLocation = xdga.getAppDataLocation();
    cacheLocation = xdga.getCacheLocation();
    documentsLocation = xdga.getDocumentsLocation();
    downloadLocation = xdga.getDownloadLocation();
    musicLocation = xdga.getMusicLocation();
    picturesLocation = xdga.getPicturesLocation();
    genericDataLocation = xdga.getGenericDataLocation();
    moviesLocation = xdga.getMoviesLocation();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleWhite = TextStyle(fontSize: 18, color: Colors.white);
    const textStyleTitle = TextStyle(fontSize: 20, color: Colors.black);
    const textStylePath = TextStyle(fontSize: 18, color: Colors.black54);

    const spaceMedium = SizedBox(height: 16);
    const spacerSmall = SizedBox(height: 8);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example xdga_directories'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Demo application demonstration use xdga_directories',
                        style: textStyleWhite,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // getAppDataLocation
                  const Text(
                    'getAppDataLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    appDataLocation,
                    style: textStylePath,
                  ),
                  spaceMedium,

                  // getCacheLocation
                  const Text(
                    'getCacheLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    cacheLocation,
                    style: textStylePath,
                  ),
                  spaceMedium,

                  // getDocumentsLocation
                  const Text(
                    'getDocumentsLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    documentsLocation,
                    style: textStylePath,
                  ),
                  spaceMedium,

                  // getDocumentsLocation
                  const Text(
                    'getDownloadLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    downloadLocation,
                    style: textStylePath,
                  ),
                  spaceMedium,

                  // getDocumentsLocation
                  const Text(
                    'getMusicLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    musicLocation,
                    style: textStylePath,
                  ),
                  spaceMedium,

                  // getDocumentsLocation
                  const Text(
                    'getPicturesLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    picturesLocation,
                    style: textStylePath,
                  ),
                  spaceMedium,

                  // getDocumentsLocation
                  const Text(
                    'getGenericDataLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    genericDataLocation,
                    style: textStylePath,
                  ),
                  spaceMedium,

                  // getDocumentsLocation
                  const Text(
                    'getMoviesLocation()',
                    style: textStyleTitle,
                  ),
                  spacerSmall,
                  Text(
                    moviesLocation,
                    style: textStylePath,
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
