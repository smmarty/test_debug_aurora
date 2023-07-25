/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'model.dart';
import 'package.dart';

class FlutterMarkdownPage extends AppStatefulWidget {
  FlutterMarkdownPage({
    super.key,
  });

  final Package package = packageFlutterMarkdown;

  @override
  State<FlutterMarkdownPage> createState() => _FlutterMarkdownPageState();
}

class _FlutterMarkdownPageState extends AppState<FlutterMarkdownPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<FlutterMarkdownModel>(
      model: getIt<FlutterMarkdownModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return Column(
          children: [
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: BlockInfoPackage(widget.package),
              ),
            ),
            Flexible(
              flex: 1,
              child: Markdown(
                controller: _scrollController,
                padding: const EdgeInsets.all(20.0),
                data: model.data,
              ),
            ),
          ],
        );
      },
    );
  }
}
