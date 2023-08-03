// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsAurora;
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/shared_preferences/model.dart';
import 'package:flutter_example_packages/packages/shared_preferences/package.dart';
import 'package:flutter_example_packages/theme/colors.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility_aurora/flutter_keyboard_visibility_aurora.dart';

class SharedPreferencesPage extends AppStatefulWidget {
  SharedPreferencesPage({
    super.key,
  });

  final Package package = packageSharedPreferences;

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends AppState<SharedPreferencesPage> {
  double _keyboardHeight = 0;
  StreamSubscription? _streamSub;
  final _controllerAurora = FlutterKeyboardVisibilityAurora();
  final ScrollController _scrollController = ScrollController();
  final model = getIt<SharedPreferencesModel>();

  bool _formIsValid = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _intController =
      TextEditingController(text: '100');
  final TextEditingController _boolController =
      TextEditingController(text: 'true');
  final TextEditingController _doubleController =
      TextEditingController(text: '100.5');
  final TextEditingController _stringController =
      TextEditingController(text: 'My text');
  final TextEditingController _listController =
      TextEditingController(text: 'First, Second, Third');

  @override
  void initState() {
    super.initState();
    model.reloadValues();
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
    return BlockLayout<SharedPreferencesModel>(
      model: model,
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitleLarge(l10n.sharedPreferencesTitleState),
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
                                  .convert(model.readValues),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              // reload data
                              await model.clear();
                              // reload data
                              await model.reloadValues();
                              // disable keyboard
                              FocusManager.instance.primaryFocus?.unfocus();
                              // scroll to top
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: TextBodyLarge(
                              l10n.sharedPreferencesFieldBtnClean,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextTitleLarge(l10n.sharedPreferencesTitleUpdate),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _intController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.sharedPreferencesFieldInt,
                          ),
                          validator: (value) {
                            if (int.tryParse(value ?? '') == null) {
                              return l10n.sharedPreferencesFieldError('int');
                            }
                            return null;
                          },
                          onChanged: (_) => setState(() {
                            _formIsValid =
                                _formKey.currentState?.validate() ?? true;
                          }),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _boolController,
                          decoration: InputDecoration(
                            labelText: l10n.sharedPreferencesFieldBool,
                          ),
                          validator: (value) {
                            if (value != 'true' && value != 'false') {
                              return l10n.sharedPreferencesFieldError('bool');
                            }
                            return null;
                          },
                          onChanged: (_) => setState(() {
                            _formIsValid =
                                _formKey.currentState?.validate() ?? true;
                          }),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _doubleController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.sharedPreferencesFieldDouble,
                          ),
                          validator: (value) {
                            if (double.tryParse(value ?? '') == null) {
                              return l10n.sharedPreferencesFieldError('double');
                            }
                            return null;
                          },
                          onChanged: (_) => setState(() {
                            _formIsValid =
                                _formKey.currentState?.validate() ?? true;
                          }),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _stringController,
                          decoration: InputDecoration(
                            labelText: l10n.sharedPreferencesFieldString,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _listController,
                          decoration: InputDecoration(
                            labelText: l10n.sharedPreferencesFieldList,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _formIsValid
                                ? () async {
                                    // add int
                                    await model.setValueInt(
                                        int.parse(_intController.text));
                                    // add bool
                                    await model.setValueBool(
                                        _boolController.text == 'true');
                                    // add double
                                    await model.setValueDouble(
                                        double.parse(_doubleController.text));
                                    // add string
                                    await model
                                        .setValueString(_stringController.text);
                                    // add list
                                    await model.setValueList(
                                        _listController.text.split(', '));
                                    // reload data
                                    await model.reloadValues();
                                    // disable keyboard
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    // scroll to top
                                    _scrollController.animateTo(
                                      0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                : null,
                            child: TextBodyLarge(
                              l10n.sharedPreferencesFieldBtn,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
