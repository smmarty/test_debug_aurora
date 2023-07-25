/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/package/package_dialog.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PackageInfoDialog extends AppStatelessWidget {
  const PackageInfoDialog({
    super.key,
    required this.package,
  });

  final PackageDialog package;

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.small),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitleLarge(package.key),
            const SizedBox(height: 15),
            TextBodyMedium(package.message),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromHeight(33),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.commonClose),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
