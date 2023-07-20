/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/widgets/texts/text_base.dart';

class TextTitleMedium extends TextBase {
  const TextTitleMedium(
    super.data, {
    super.key,
    super.color,
    super.textAlign,
    super.fontWeight,
  });

  @override
  TextStyle? getStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium;
  }
}
