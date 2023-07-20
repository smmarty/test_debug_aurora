/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/wakelock/model.dart';
import 'package:flutter_example_packages/packages/wakelock/package.dart';
import 'package:flutter_example_packages/theme/colors.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WakelockPage extends AppStatefulWidget {
  WakelockPage({
    super.key,
  });

  final Package package = packageWakelock;

  @override
  State<WakelockPage> createState() => _WakelockPageState();
}

class _WakelockPageState extends AppState<WakelockPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<WakelockModel>(
      model: getIt<WakelockModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                BlockAlert(model.error),
                if (!model.isError)
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitleLarge(l10n.wakelockTitle),
                            const SizedBox(height: 8),
                            TextBodyMedium(l10n.wakelockDesc),
                          ],
                        ),
                      ),
                      FutureBuilder<bool?>(
                        future: model.isEnable(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<bool?> snapshot,
                        ) {
                          final value = snapshot.data ?? false;
                          return Expanded(
                            flex: 0,
                            child: Switch(
                              // This bool value toggles the switch.
                              value: value,
                              activeColor: AppColors.secondary,
                              onChanged: (bool value) {
                                model.setStateWakelock(value);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
