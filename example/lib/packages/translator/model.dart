// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:translator/translator.dart';

/// Model for [TranslatorPage]
class TranslatorModel extends Model {
  /// Get [ScopedModel]
  static TranslatorModel of(BuildContext context) =>
      ScopedModel.of<TranslatorModel>(context);

  final translator = GoogleTranslator();

  Future<Translation> translate(
    String value,
  ) async {
    return await translator.translate(value, from: 'en', to: 'ru');
  }
}
