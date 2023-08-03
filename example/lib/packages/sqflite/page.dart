// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsAurora;
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/sqflite/widgets/form_delete.dart';
import 'package:flutter_example_packages/packages/sqflite/widgets/form_insert.dart';
import 'package:flutter_example_packages/packages/sqflite/widgets/form_update.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility_aurora/flutter_keyboard_visibility_aurora.dart';

import 'model.dart';
import 'package.dart';

class SqflitePage extends AppStatefulWidget {
  SqflitePage({
    super.key,
  });

  final Package package = packageSqflite;

  @override
  State<SqflitePage> createState() => _SqflitePageState();
}

class _SqflitePageState extends AppState<SqflitePage> {
  final _model = getIt<SqfliteModel>();
  bool _loading = true;

  final ScrollController _scrollController = ScrollController();
  final _controllerAurora = FlutterKeyboardVisibilityAurora();
  StreamSubscription? _streamSub;
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    // Init database
    _model.init().then((_) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    });
    // Get keyboard height
    if (kIsAurora) {
      _streamSub = _controllerAurora.onChangeHeight.listen((event) {
        setState(() {
          _keyboardHeight = event;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Close database
    _model.close();
    // Cancel listen
    _streamSub?.cancel();
  }

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<SqfliteModel>(
      model: _model,
      loading: _loading,
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(bottom: _keyboardHeight),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                BlockAlert(model.error),
                if (!model.isError)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitleLarge(l10n.sqfliteTitleState),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: AppRadius.small,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextBodyMedium(
                            const JsonEncoder.withIndent('   ')
                                .convert(model.data),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: model.data.isEmpty
                              ? null
                              : () async {
                                  await model.clear();
                                  _scrollToTop();
                                },
                          child: TextBodyLarge(
                            l10n.sqfliteTitleBtnClear,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextTitleLarge(l10n.sqfliteTitleInsert),
                      const SizedBox(height: 20),
                      SqfliteFormInsert((
                        String name,
                        int value,
                        double num,
                      ) async {
                        await model.insert(name, value, num);
                        _scrollToTop();
                      }),
                      const SizedBox(height: 20),
                      TextTitleLarge(l10n.sqfliteTitleUpdate),
                      const SizedBox(height: 20),
                      SqfliteFormUpdate((
                        int id,
                        String name,
                        int value,
                        double num,
                      ) async {
                        if (await model.update(id, name, value, num)) {
                          _scrollToTop();
                          return true;
                        }
                        return false;
                      }),
                      const SizedBox(height: 20),
                      TextTitleLarge(l10n.sqfliteTitleDelete),
                      const SizedBox(height: 20),
                      SqfliteFormDelete((int id) async {
                        if (await model.delete(id)) {
                          _scrollToTop();
                          return true;
                        }
                        return false;
                      }),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  void _scrollToTop() {
    // scroll to top
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
