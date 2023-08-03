// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'dart:async';

import 'package:flutter/foundation.dart' show kIsAurora;
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility_aurora/flutter_keyboard_visibility_aurora.dart';

import 'model.dart';
import 'package.dart';

class DartzPage extends AppStatefulWidget {
  DartzPage({
    super.key,
  });

  final Package package = packageDartz;

  @override
  State<DartzPage> createState() => _DartzPageState();
}

class _DartzPageState extends AppState<DartzPage> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _sizeEUR;
  bool _isError = false;

  double _keyboardHeight = 0;
  StreamSubscription? _streamSub;
  final _controllerAurora = FlutterKeyboardVisibilityAurora();

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
    return BlockLayout<DartzModel>(
      model: getIt<DartzModel>(),
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlockItem(
                        title: l10n.dartzTitle,
                        desc: l10n.dartzDesc,
                        value: _sizeEUR ?? l10n.dartzDefaultValue,
                      ),
                      TextFormField(
                        controller: _textController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: l10n.dartzLabel,
                          errorText: _isError ? l10n.dartzErrorFound : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.dartzErrorReq;
                          }
                          if (int.tryParse(value) == null) {
                            return l10n.dartzErrorInt;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              final sizeRU = int.parse(_textController.text);
                              model
                                  .getEURManSize(sizeRU)
                                  .map(
                                    (classification) => setState(() {
                                      _isError = false;
                                      _sizeEUR = classification;
                                    }),
                                  )
                                  .getOrElse(
                                    () => setState(() {
                                      _sizeEUR = null;
                                      _isError = true;
                                    }),
                                  );
                            }
                          },
                          child: TextBodyLarge(
                            l10n.dartzSubmit,
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
