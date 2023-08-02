// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SqfliteFormInsert extends AppStatefulWidget {
  const SqfliteFormInsert(
    this.submit, {
    super.key,
  });

  final Future<void> Function(
    String name,
    int value,
    double num,
  ) submit;

  @override
  State<SqfliteFormInsert> createState() => _SqfliteFormInsertState();
}

class _SqfliteFormInsertState extends AppState<SqfliteFormInsert> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _numController = TextEditingController();

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
            controller: _nameController,
            decoration: InputDecoration(
              labelText: l10n.sqfliteTitleFieldName,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.sqfliteTitleValidateRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _valueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.sqfliteTitleFieldValue,
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
          const SizedBox(height: 16),
          TextFormField(
            controller: _numController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.sqfliteTitleFieldNum,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.sqfliteTitleValidateRequired;
              }
              if (double.tryParse(value.replaceAll(',', '.')) == null) {
                return l10n.sqfliteTitleValidateType('double');
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
                  // Clear focus
                  FocusScope.of(context).unfocus();
                  // Send submit
                  await widget.submit(
                    _nameController.text,
                    int.parse(_valueController.text),
                    double.parse(_numController.text.replaceAll(',', '.')),
                  );
                  // Clear form
                  _nameController.clear();
                  _valueController.clear();
                  _numController.clear();
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
