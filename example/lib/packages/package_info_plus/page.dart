// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/package_info_plus/model.dart';
import 'package:flutter_example_packages/packages/package_info_plus/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PackageInfoPlusPage extends AppStatefulWidget {
  PackageInfoPlusPage({
    super.key,
  });

  final Package package = packagePackageInfoPlus;

  @override
  State<PackageInfoPlusPage> createState() => _PackageInfoPlusPageState();
}

class _PackageInfoPlusPageState extends AppState<PackageInfoPlusPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<PackageInfoPlusModel>(
      model: getIt<PackageInfoPlusModel>(),
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
                        title: l10n.packageInfoPlusTitlePackageName,
                        desc: l10n.packageInfoPlusDescPackageName,
                        future: model.getPackageName(),
                      ),
                      BlockItem(
                        title: l10n.packageInfoPlusTitleApplicationName,
                        desc: l10n.packageInfoPlusDescApplicationName,
                        future: model.getApplicationName(),
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
