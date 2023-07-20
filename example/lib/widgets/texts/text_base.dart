/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';

class TextBase extends StatelessWidget {
  const TextBase(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.fontWeight,
  });

  final String data;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  TextStyle? getStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: getStyle(context)?.copyWith(color: color ?? Colors.black).copyWith(
            fontWeight: fontWeight,
          ),
      textAlign: textAlign,
    );
  }
}
