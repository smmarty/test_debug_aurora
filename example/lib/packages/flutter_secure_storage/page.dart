/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'dart:async';

import 'package:flutter/foundation.dart' show kIsAurora;
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/flutter_secure_storage/model.dart';
import 'package:flutter_example_packages/packages/flutter_secure_storage/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility_aurora/flutter_keyboard_visibility_aurora.dart';

class FlutterSecureStoragePage extends AppStatefulWidget {
  FlutterSecureStoragePage({
    super.key,
  });

  final Package package = packageFlutterSecureStorage;

  @override
  State<FlutterSecureStoragePage> createState() =>
      _FlutterSecureStoragePageState();
}

class _FlutterSecureStoragePageState
    extends AppState<FlutterSecureStoragePage> {
  double _keyboardHeight = 0;
  StreamSubscription? _streamSub;
  final _controllerAurora = FlutterKeyboardVisibilityAurora();

  bool _isValidSave = false;
  final TextEditingController _passSaveController = TextEditingController();
  final TextEditingController _keySaveController = TextEditingController();
  final TextEditingController _valueSaveController = TextEditingController();

  bool _isValidGet = false;
  final TextEditingController _passGetController = TextEditingController();
  final TextEditingController _keyGetController = TextEditingController();
  final TextEditingController _valueGetController = TextEditingController();

  void _validateSave() {
    setState(() {
      _isValidSave = _passSaveController.text.isNotEmpty &&
          _keySaveController.text.isNotEmpty &&
          _valueSaveController.text.isNotEmpty;
    });
  }

  void _validateGet() {
    setState(() {
      _isValidGet = _passGetController.text.isNotEmpty &&
          _keyGetController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
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
    _streamSub?.cancel();
  }

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<FlutterSecureStorageModel>(
      model: getIt<FlutterSecureStorageModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        // update read only value
        _valueGetController.text = model.readValue;
        // return widget
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
                      TextTitleLarge(l10n.flutterSecureStorageTitleSave),
                      const SizedBox(height: 14),
                      if (model.isSuccess)
                        BlockAlert(
                          l10n.flutterSecureStorageSuccess,
                          color: Colors.lightGreen,
                        ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _passSaveController,
                        decoration: InputDecoration(
                          labelText: l10n.flutterSecureStorageFieldPass,
                        ),
                        onChanged: (_) => _validateSave(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _keySaveController,
                        decoration: InputDecoration(
                          labelText: l10n.flutterSecureStorageFieldKey,
                        ),
                        onChanged: (_) => _validateSave(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _valueSaveController,
                        decoration: InputDecoration(
                          labelText: l10n.flutterSecureStorageFieldValue,
                        ),
                        onChanged: (_) => _validateSave(),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isValidSave
                              ? () => model.write(
                                    key: _keySaveController.text,
                                    value: _valueSaveController.text,
                                    password: _passSaveController.text,
                                  )
                              : null,
                          child: TextBodyLarge(
                            l10n.flutterSecureStorageBtnSave,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextTitleLarge(l10n.flutterSecureStorageTitleGet),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passGetController,
                        decoration: InputDecoration(
                          labelText: l10n.flutterSecureStorageFieldPass,
                        ),
                        onChanged: (_) {
                          _validateGet();
                          model.clearReadValue();
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                          controller: _keyGetController,
                          decoration: InputDecoration(
                            labelText: l10n.flutterSecureStorageFieldKey,
                          ),
                          onChanged: (_) {
                            _validateGet();
                            model.clearReadValue();
                          }),
                      const SizedBox(height: 16),
                      TextField(
                        enabled: false,
                        readOnly: true,
                        controller: _valueGetController,
                        decoration: InputDecoration(
                          labelText: l10n.flutterSecureStorageFieldValue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isValidGet
                              ? () => model.read(
                                    key: _keyGetController.text,
                                    password: _passGetController.text,
                                  )
                              : null,
                          child: TextBodyLarge(
                            l10n.flutterSecureStorageBtnGet,
                            color: Colors.white,
                          ),
                        ),
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
