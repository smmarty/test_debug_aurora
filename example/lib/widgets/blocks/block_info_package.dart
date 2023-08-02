// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Block info package in page
class BlockInfoPackage extends AppStatelessWidget {
  const BlockInfoPackage(
    this.package, {
    super.key,
  });

  final Package package;

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: AppRadius.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBodyMedium(package.desc),
          const SizedBox(height: 8),
          Divider(
            height: 1,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.verified, size: 14, color: Colors.green),
              const SizedBox(width: 6),
              TextBodySmall(package.version),
              const SizedBox(width: 10),
              Icon(
                Icons.auto_awesome_motion,
                size: 14,
                color: package.isPlatformDependent
                    ? Colors.deepOrange
                    : Colors.blueAccent,
              ),
              const SizedBox(width: 6),
              TextBodySmall(
                package.isPlatformDependent
                    ? l10n.homeListStateDependent
                    : l10n.homeListStateIndependent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
