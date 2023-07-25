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
import 'package:qr_flutter/qr_flutter.dart';

import 'model.dart';
import 'package.dart';

class QrFlutterPage extends AppStatefulWidget {
  QrFlutterPage({
    super.key,
  });

  final Package package = packageQrFlutter;

  @override
  State<QrFlutterPage> createState() => _QrFlutterPageState();
}

class _QrFlutterPageState extends AppState<QrFlutterPage> {
  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<QrFlutterModel>(
      model: getIt<QrFlutterModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                Center(
                  child: QrImage(
                    data: '1234567890',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
