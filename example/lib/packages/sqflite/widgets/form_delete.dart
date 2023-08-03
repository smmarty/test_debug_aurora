// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SqfliteFormDelete extends AppStatefulWidget {
  const SqfliteFormDelete(
    this.submit, {
    super.key,
  });

  final Future<bool> Function(
    int id,
  ) submit;

  @override
  State<SqfliteFormDelete> createState() => _SqfliteFormDeleteState();
}

class _SqfliteFormDeleteState extends AppState<SqfliteFormDelete> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  bool _isError = false;

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _idController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.sqfliteTitleFieldID,
              errorText: _isError ? l10n.sqfliteTitleError : null,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.sqfliteTitleValidateRequired;
              }
              if (int.tryParse(value) == null) {
                return l10n.sqfliteTitleValidateType('int');
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
                  // Send submit
                  if (await widget.submit(
                    int.parse(_idController.text),
                  )) {
                    // Clear focus
                    FocusScope.of(context).unfocus();
                    // Clear form
                    _idController.clear();
                    // Clear error
                    setState(() {
                      _isError = false;
                    });
                  } else {
                    // Show error
                    setState(() {
                      _isError = true;
                    });
                  }
                }
              },
              child: TextBodyLarge(
                l10n.sqfliteTitleBtnSubmit,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
