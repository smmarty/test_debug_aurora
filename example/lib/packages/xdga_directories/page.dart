/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/xdga_directories/model.dart';
import 'package:flutter_example_packages/packages/xdga_directories/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/blocks/block_item.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class XdgaDirectoriesPage extends AppStatefulWidget {
  XdgaDirectoriesPage({
    super.key,
  });

  final Package package = packageXdgaDirectories;

  @override
  State<XdgaDirectoriesPage> createState() => _XdgaDirectoriesPageState();
}

class _XdgaDirectoriesPageState extends AppState<XdgaDirectoriesPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<XdgaDirectoriesModel>(
      model: getIt<XdgaDirectoriesModel>(),
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
                        title: l10n.xdgaDirectoriesTitleCacheLocation,
                        desc: l10n.xdgaDirectoriesDescCacheLocation,
                        value: model.getCacheLocation(),
                      ),
                      BlockItem(
                        title: l10n.xdgaDirectoriesTitleAppDataLocation,
                        desc: l10n.xdgaDirectoriesDescAppDataLocation,
                        value: model.getAppDataLocation(),
                      ),
                      BlockItem(
                        title: l10n.xdgaDirectoriesTitleDocumentsLocation,
                        desc: l10n.xdgaDirectoriesDescDocumentsLocation,
                        value: model.getDocumentsLocation(),
                      ),
                      BlockItem(
                        title: l10n.xdgaDirectoriesTitleDownloadLocation,
                        desc: l10n.xdgaDirectoriesDescDownloadLocation,
                        value: model.getDownloadLocation(),
                      ),
                      BlockItem(
                        title: l10n.xdgaDirectoriesTitleMusicLocation,
                        desc: l10n.xdgaDirectoriesDescMusicLocation,
                        value: model.getMusicLocation(),
                      ),
                      BlockItem(
                        title: l10n.xdgaDirectoriesTitlePicturesLocation,
                        desc: l10n.xdgaDirectoriesDescPicturesLocation,
                        value: model.getPicturesLocation(),
                      ),
                      BlockItem(
                        title: l10n.xdgaDirectoriesTitleGenericDataLocation,
                        desc: l10n.xdgaDirectoriesDescGenericDataLocation,
                        value: model.getGenericDataLocation(),
                      ),
                      BlockItem(
                        title: l10n.xdgaDirectoriesTitleMoviesLocation,
                        desc: l10n.xdgaDirectoriesDescMoviesLocation,
                        value: model.getMoviesLocation(),
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
