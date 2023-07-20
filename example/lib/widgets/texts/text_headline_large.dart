/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/widgets/texts/text_base.dart';

class TextHeadlineLarge extends TextBase {
  const TextHeadlineLarge(
    super.data, {
    super.key,
    super.color,
    super.textAlign,
    super.fontWeight,
  });

  @override
  TextStyle? getStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge;
  }
}
