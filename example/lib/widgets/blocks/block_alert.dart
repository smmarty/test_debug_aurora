// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';

/// Alert
class BlockAlert extends StatelessWidget {
  const BlockAlert(
    this.text, {
    super.key,
    this.color = Colors.redAccent,
    this.padding = const EdgeInsets.only(bottom: 20),
  });

  final EdgeInsets padding;
  final Color color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text != null,
      child: Padding(
        padding: padding,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.small,
          ),
          child: TextBodyMedium(
            '$text',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
