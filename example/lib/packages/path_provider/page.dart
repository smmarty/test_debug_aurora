// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/path_provider/model.dart';
import 'package:flutter_example_packages/packages/path_provider/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PathProviderPage extends AppStatefulWidget {
  PathProviderPage({super.key});

  final Package package = packagePathProvider;

  @override
  State<PathProviderPage> createState() => _PathProviderPageState();
}

class _PathProviderPageState extends AppState<PathProviderPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<PathProviderModel>(
      model: getIt<PathProviderModel>(),
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
                        title: l10n.pathProviderTitleApplicationSupport,
                        desc: l10n.pathProviderDescApplicationSupport,
                        future: model.getApplicationSupportDirectory(),
                      ),
                      BlockItem(
                        title: l10n.pathProviderTitleTemporary,
                        desc: l10n.pathProviderDescTemporary,
                        future: model.getTemporaryDirectory(),
                      ),
                      BlockItem(
                        title: l10n.pathProviderTitleApplicationDocuments,
                        desc: l10n.pathProviderDescApplicationDocuments,
                        future: model.getApplicationDocumentsDirectory(),
                      ),
                      BlockItem(
                        title: l10n.pathProviderTitleDownloads,
                        desc: l10n.pathProviderDescDownloads,
                        future: model.getDownloadsDirectory(),
                      ),
                      BlockItem(
                        title: l10n.pathProviderTitlePictures,
                        desc: l10n.pathProviderDescPictures,
                        future: model.getExternalStorageDirectoriesPictures(),
                      ),
                      BlockItem(
                        title: l10n.pathProviderTitleMusic,
                        desc: l10n.pathProviderDescMusic,
                        future: model.getExternalStorageDirectoriesMusic(),
                      ),
                      BlockItem(
                        title: l10n.pathProviderTitleMovies,
                        desc: l10n.pathProviderDescMovies,
                        future: model.getExternalStorageDirectoriesMovies(),
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
