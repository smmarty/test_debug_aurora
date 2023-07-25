/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/battery_plus/model.dart';
import 'package:flutter_example_packages/packages/battery_plus/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BatteryPlusPage extends AppStatefulWidget {
  BatteryPlusPage({
    super.key,
  });

  final Package package = packageBatteryPlus;

  @override
  State<BatteryPlusPage> createState() => _BatteryPlusPageState();
}

class _BatteryPlusPageState extends AppState<BatteryPlusPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<BatteryPlusModel>(
      model: getIt<BatteryPlusModel>(),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlockItem(
                        title: l10n.batteryPlusTitleBatteryLevel,
                        desc: l10n.batteryPlusDescBatteryLevel,
                        future: model.getBatteryLevel(),
                        builder: (value) => '$value%',
                      ),
                      BlockItem(
                        title: l10n.batteryPlusTitleBatteryState,
                        desc: l10n.batteryPlusDescBatteryState,
                        future: model.getBatteryState(),
                        builder: (value) =>
                            value.toString().split('.').last.toUpperCase(),
                      ),
                      BlockItem(
                        title: l10n.batteryPlusTitleBatterySaveMode,
                        desc: l10n.batteryPlusDescBatterySaveMode,
                        future: model.isInBatterySaveMode(),
                      ),
                      BlockItem(
                        title: l10n.batteryPlusTitleBatteryStateLive,
                        desc: l10n.batteryPlusDescBatteryStateLive,
                        stream: model.onBatteryStateChanged(),
                        builder: (value) =>
                            value.toString().split('.').last.toUpperCase(),
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
