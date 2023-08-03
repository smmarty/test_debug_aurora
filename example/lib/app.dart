// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/packages.dart';
import 'package:flutter_example_packages/pages/home/page.dart';
import 'package:flutter_example_packages/theme/theme.dart';
import 'package:flutter_example_packages/widgets/layouts/page_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Main app class
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      '/': (context) => const HomePage(),
    };
    for (var item in packages) {
      if (item is PackagePage) {
        routes['/${item.key}'] = (context) => PageLayout(
              child: item.page.call(),
            );
      }
    }

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/',
      routes: routes,
    );
  }
}
