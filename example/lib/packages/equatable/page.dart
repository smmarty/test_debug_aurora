/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
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

class EquatablePage extends AppStatefulWidget {
  EquatablePage({
    super.key,
  });

  final Package package = packageEquatable;

  @override
  State<EquatablePage> createState() => _EquatablePageState();
}

class _EquatablePageState extends AppState<EquatablePage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<EquatableModel>(
      model: getIt<EquatableModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                TextTitleLarge(l10n.equatableTitleDefault),
                const SizedBox(height: 8),
                TextBodyMedium(l10n.equatableSubtitle),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: AppRadius.small,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextBodyMedium(model.userEntity.toString()),
                  ),
                ),
                const SizedBox(height: 20),
                TextTitleLarge(l10n.equatableTitleFreezed),
                const SizedBox(height: 8),
                TextBodyMedium(l10n.equatableSubtitle),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: AppRadius.small,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextBodyMedium(model.userEntityEquatable.toString()),
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
