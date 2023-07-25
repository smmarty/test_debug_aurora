/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model.dart';
import 'package.dart';

class FreezedPage extends AppStatefulWidget {
  FreezedPage({
    super.key,
  });

  final Package package = packageFreezed;

  @override
  State<FreezedPage> createState() => _FreezedPageState();
}

class _FreezedPageState extends AppState<FreezedPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<FreezedModel>(
      model: getIt<FreezedModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                TextTitleLarge(l10n.freezedTitleDefault),
                const SizedBox(height: 8),
                TextBodyMedium(l10n.freezedSubtitle),
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
                      const JsonEncoder.withIndent('   ').convert(
                          model.userEntity.copyWith(name: 'My name').toJson()),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextTitleLarge(l10n.freezedTitleFreezed),
                const SizedBox(height: 8),
                TextBodyMedium(l10n.freezedSubtitle),
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
                      const JsonEncoder.withIndent('   ').convert(model
                          .userEntityFreezed
                          .copyWith(name: 'My name')
                          .toJson()),
                    ),
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
