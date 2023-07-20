/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model.dart';
import 'package.dart';

class RxdartPage extends AppStatefulWidget {
  RxdartPage({
    super.key,
  });

  final Package package = packageRxdart;

  @override
  State<RxdartPage> createState() => _RxdartPageState();
}

class _RxdartPageState extends AppState<RxdartPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<RxdartModel>(
      model: getIt<RxdartModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                BlockItem(
                  title: l10n.rxdartTitle,
                  desc: l10n.rxdartSubtitle,
                  future: model.getNumberList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
