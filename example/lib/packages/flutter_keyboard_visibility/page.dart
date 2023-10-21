// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'dart:async';

import 'package:flutter/foundation.dart' show kIsAurora;
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model.dart';
import 'package.dart';

class FlutterKeyboardVisibilityPage extends AppStatefulWidget {
  FlutterKeyboardVisibilityPage({
    super.key,
  });

  final Package package = packageFlutterKeyboardVisibility;

  @override
  State<FlutterKeyboardVisibilityPage> createState() =>
      _FlutterKeyboardVisibilityPageState();
}

class _FlutterKeyboardVisibilityPageState
    extends AppState<FlutterKeyboardVisibilityPage> {
  double _keyboardHeight = 0;
  StreamSubscription? _streamSub;
  final model = getIt<FlutterKeyboardVisibilityModel>();

  @override
  void initState() {
    super.initState();
    if (kIsAurora) {
      _streamSub = model.onChangeKeyboardHeight().listen((height) {
        setState(() {
          _keyboardHeight = height;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streamSub?.cancel();
  }

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<FlutterKeyboardVisibilityModel>(
      model: model,
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
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
                      TextField(
                        decoration: InputDecoration(
                          hintText: l10n.flutterKeyboardVisibilityField,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () => FocusScope.of(context).unfocus(),
                          child: TextBodyLarge(
                            l10n.flutterKeyboardVisibilityButton,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: kIsAurora,
                        child: BlockItem(
                          title: l10n.flutterKeyboardVisibilityTitleHeight,
                          desc: l10n.flutterKeyboardVisibilityDescHeight,
                          value: _keyboardHeight,
                          builder: (value) => value?.toInt().toString(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlockItem(
                        title: l10n.flutterKeyboardVisibilityTitle,
                        desc: l10n.flutterKeyboardVisibilityDesc,
                        stream: model.onChangeKeyboard(),
                        builder: (value) => value.toString().toUpperCase(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
