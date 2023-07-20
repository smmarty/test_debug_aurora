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
import 'package:provider/provider.dart';

import 'model.dart';
import 'package.dart';

class ProviderPage extends AppStatefulWidget {
  ProviderPage({
    super.key,
  });

  final Package package = packageProvider;

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends AppState<ProviderPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return FutureProvider<int>(
      initialData: 0,
      create: (context) => Future.value(12345), // Set value
      child: BlockLayout<ProviderModel>(
        model: getIt<ProviderModel>(),
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
                    title: l10n.providerTitle,
                    desc: l10n.providerSubtitle,
                    value: context.watch<int>(), // Get value
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
