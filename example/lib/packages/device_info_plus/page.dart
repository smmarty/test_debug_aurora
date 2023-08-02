// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/device_info_plus/model.dart';
import 'package:flutter_example_packages/packages/device_info_plus/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeviceInfoPlusPage extends AppStatefulWidget {
  DeviceInfoPlusPage({
    super.key,
  });

  final Package package = packageDeviceInfoPlus;

  @override
  State<DeviceInfoPlusPage> createState() => _DeviceInfoPlusPageState();
}

class _DeviceInfoPlusPageState extends AppState<DeviceInfoPlusPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<DeviceInfoPlusModel>(
      model: getIt<DeviceInfoPlusModel>(),
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
                        title: l10n.deviceInfoPlusTitleID,
                        desc: l10n.deviceInfoPlusDescID,
                        future: model.getID(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleName,
                        desc: l10n.deviceInfoPlusDescName,
                        future: model.getName(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleVersion,
                        desc: l10n.deviceInfoPlusDescVersion,
                        future: model.getVersion(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitlePrettyName,
                        desc: l10n.deviceInfoPlusDescName,
                        future: model.getPrettyName(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleGNSS,
                        desc: l10n.deviceInfoPlusDescGNSS,
                        future: model.hasGNSS(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleNFC,
                        desc: l10n.deviceInfoPlusDescNFC,
                        future: model.hasNFC(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleBluetooth,
                        desc: l10n.deviceInfoPlusDescBluetooth,
                        future: model.hasBluetooth(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleWlan,
                        desc: l10n.deviceInfoPlusDescWlan,
                        future: model.hasWlan(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleMaxCpuClockSpeed,
                        desc: l10n.deviceInfoPlusDescMaxCpuClockSpeed,
                        future: model.getMaxCpuClockSpeed(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleNumberCpuCores,
                        desc: l10n.deviceInfoPlusDescNumberCpuCores,
                        future: model.getNumberCpuCores(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleBatteryCharge,
                        desc: l10n.deviceInfoPlusDescBatteryCharge,
                        future: model.getBatteryChargePercentage(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleMainCameraResolution,
                        desc: l10n.deviceInfoPlusDescMainCameraResolution,
                        future: model.getMainCameraResolution(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleFrontalCameraResolution,
                        desc: l10n.deviceInfoPlusDescFrontalCameraResolution,
                        future: model.getFrontalCameraResolution(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleRamTotalSize,
                        desc: l10n.deviceInfoPlusDescRamTotalSize,
                        future: model.getRamTotalSize(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleRamFreeSize,
                        desc: l10n.deviceInfoPlusDescRamFreeSize,
                        future: model.getRamFreeSize(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleScreenResolution,
                        desc: l10n.deviceInfoPlusDescScreenResolution,
                        future: model.getScreenResolution(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleOsVersion,
                        desc: l10n.deviceInfoPlusDescOsVersion,
                        future: model.getOsVersion(),
                      ),
                      BlockItem(
                        title: l10n.deviceInfoPlusTitleDeviceModel,
                        desc: l10n.deviceInfoPlusDescDeviceModel,
                        future: model.getDeviceModel(),
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
