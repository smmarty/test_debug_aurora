// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/extensions/keys_ext.dart';
import 'package:flutter_example_packages/pages/home/model.dart';
import 'package:flutter_example_packages/pages/home/widgets/home_app_bar.dart';
import 'package:flutter_example_packages/pages/home/widgets/package_list_item.dart';
import 'package:flutter_example_packages/theme/colors.dart';
import 'package:flutter_example_packages/widgets/base/app_state.dart';
import 'package:flutter_example_packages/widgets/base/app_stateful_widget.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends AppStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AppState<HomePage> {
  double _hH = 0;
  final _header = GlobalKey();
  final HomeModel _model = getIt<HomeModel>();
  final ScrollController _controllerListView = ScrollController();

  @override
  void onDidChangeMetrics() {
    setState(() {
      _hH = _header.getHeight() ?? 0;
    });
  }

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<HomeModel>(
        model: _model,
        builder: (context, child, model) {
          return Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: HomeAppBar(
              onChangeFiltered: (String search, PlatformFilter filter) {
                if (model.filteredPackages.isNotEmpty) {
                  _controllerListView.jumpTo(0);
                }
                model.updateFilterState(search, filter);
              },
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Stack(
                children: [
                  Visibility(
                    visible: !model.isSearch,
                    child: Container(
                      height: _hH > 0 ? _hH : 0,
                      color: AppColors.primary,
                      width: double.infinity,
                      child: Center(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 40,
                            ),
                            child: Opacity(
                              opacity: 0.2,
                              child: Image.asset(
                                'assets/images/logo-head.png',
                                width: 250,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !model.isSearch,
                    child: Container(
                      key: _header,
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top:
                            media.orientation == Orientation.portrait ? 30 : 10,
                        bottom:
                            media.orientation == Orientation.portrait ? 90 : 70,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeadlineMedium(
                            l10n.homeWelcomeTitle,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: media.orientation == Orientation.portrait
                                ? 40
                                : 20,
                          ),
                          TextTitleMedium(
                            l10n.homeWelcomeText(model.fullSize),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (model.filteredPackages.isNotEmpty)
                    ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      controller: _controllerListView,
                      padding: EdgeInsets.only(
                          top: _hH > 0 && !model.isSearch ? _hH - 20 : 0),
                      itemCount: model.filteredPackages.length,
                      itemBuilder: (context, index) {
                        return PackageListItemWidget(
                          index: index,
                          item: model.filteredPackages[index],
                        );
                      },
                    ),
                  if (model.filteredPackages.isEmpty)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 0,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextTitleLarge(
                                  l10n.homeNotFoundTitle,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 40),
                                TextBodyMedium(
                                  l10n.homeNotFoundSubtitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
