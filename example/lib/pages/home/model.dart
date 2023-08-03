// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/widgets.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/base/package/package_page.dart';
import 'package:flutter_example_packages/packages/packages.dart' as list;
import 'package:flutter_example_packages/pages/home/widgets/home_app_bar.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [HomePage]
class HomeModel extends Model {
  /// Get [ScopedModel]
  static HomeModel of(BuildContext context) =>
      ScopedModel.of<HomeModel>(context);

  /// Get all list packages
  final List<Package> packages = list.packages;

  /// Filtered list packages
  List<Package> _filteredPackages = list.packages;

  /// Public filtered list packages
  List<Package> get filteredPackages => _filteredPackages;

  /// Get count packages
  int get fullSize => packages.length;

  /// Check is search
  bool get isSearch => _search.isNotEmpty;

  /// Search text
  String _search = "";

  /// Filter list packages
  PlatformFilter _filter = PlatformFilter.disable;

  /// Update state filtered
  void updateFilterState(
    String search,
    PlatformFilter filter,
  ) {
    _search = search;
    _filter = filter;
    _filteredPackages = _filterPackages();
    notifyListeners();
  }

  /// Filter list packages
  List<Package> _filterPackages() {
    return packages.where((element) {
      bool result = true;
      switch (_filter) {
        case PlatformFilter.dependent:
          result = element.isPlatformDependent == true;
          break;
        case PlatformFilter.independent:
          result = element.isPlatformDependent == false;
          break;
        case PlatformFilter.demo:
          result = element is PackagePage;
          break;
        case PlatformFilter.disable:
          break;
      }
      if (_search.isNotEmpty) {
        if (!element.key.contains(_search)) {
          result = false;
        }
      }
      return result;
    }).toList();
  }
}
