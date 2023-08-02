// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/cached_network_image/model.dart';
import 'package:flutter_example_packages/packages/cached_network_image/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CachedNetworkImagePage extends AppStatefulWidget {
  CachedNetworkImagePage({
    super.key,
  });

  final Package package = packageCachedNetworkImage;

  @override
  State<CachedNetworkImagePage> createState() => _CachedNetworkImagePageState();
}

class _CachedNetworkImagePageState extends AppState<CachedNetworkImagePage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<CachedNetworkImageModel>(
      model: getIt<CachedNetworkImageModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: "https://via.placeholder.com/350x150",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
