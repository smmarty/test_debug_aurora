// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  );

  void onPostFrameCallback() {}
  void onDidChangeMetrics() {}

  void _delayedChangeMetrics() {
    for (int i = 0; i <= 5; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (mounted) {
          onDidChangeMetrics();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _delayedChangeMetrics();
    });
  }

  @override
  void didChangeMetrics() {
    _delayedChangeMetrics();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => buildWide(
        context,
        MediaQuery.of(context),
        AppLocalizations.of(context)!,
      );
}
