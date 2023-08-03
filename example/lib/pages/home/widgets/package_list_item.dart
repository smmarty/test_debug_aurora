// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/base/package/package_dialog.dart';
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/pages/home/widgets/package_info_dialog.dart';
import 'package:flutter_example_packages/theme/colors.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PackageListItemWidget extends AppStatelessWidget {
  const PackageListItemWidget({
    super.key,
    required this.index,
    required this.item,
  });

  final int index;
  final Package item;

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return Stack(
      children: [
        Visibility(
          visible: index != 0,
          child: Container(
            height: 10,
            width: double.infinity,
            transform: Matrix4.translationValues(0.0, -10, 0.0),
            color: Colors.blueGrey,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: index == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                : null,
          ),
          child: Padding(
            padding: index == 0
                ? const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0)
                : const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextTitleLarge(item.key),
                                    const SizedBox(height: 10),
                                    TextBodyMedium(
                                      item.desc,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(height: 12),
                                    Divider(
                                      height: 1,
                                      color: AppColors.primary.withOpacity(0.2),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: item is PackagePage,
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.visibility,
                                                size: 16,
                                                color: Colors.green,
                                              ),
                                              SizedBox(width: 6),
                                            ],
                                          ),
                                        ),
                                        TextBodySmall(
                                          l10n.homeListVersion(item.version),
                                          color: AppColors.primary
                                              .withOpacity(0.7),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: AppRadius.small,
                                ),
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  if (item is PackagePage) {
                                    Navigator.pushNamed(
                                        context, '/${item.key}');
                                  } else if (item is PackageDialog) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PackageInfoDialog(
                                            package: item as PackageDialog,
                                          );
                                        });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: item.isPlatformDependent
                              ? Colors.deepOrangeAccent
                              : Colors.blueAccent,
                          borderRadius: AppRadius.small,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                            top: 6,
                            right: 6,
                            bottom: 6,
                          ),
                          child: TextBodySmall(
                            item.isPlatformDependent
                                ? l10n.homeListStateDependent
                                : l10n.homeListStateIndependent,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
