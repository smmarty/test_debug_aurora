// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:xdga_directories/xdga_directories.dart' as xdga;

/// Model for [XdgaDirectoriesPage]
class XdgaDirectoriesModel extends Model {
  /// Get [ScopedModel]
  static XdgaDirectoriesModel of(BuildContext context) =>
      ScopedModel.of<XdgaDirectoriesModel>(context);

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// QStandardPaths::CacheLocation
  String? getCacheLocation() {
    try {
      return xdga.getCacheLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// QStandardPaths::AppDataLocation
  String? getAppDataLocation() {
    try {
      return xdga.getAppDataLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// QStandardPaths::DocumentsLocation
  String? getDocumentsLocation() {
    try {
      return xdga.getDocumentsLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// QStandardPaths::DownloadLocation
  String? getDownloadLocation() {
    try {
      return xdga.getDownloadLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// QStandardPaths::MusicLocation
  String? getMusicLocation() {
    try {
      return xdga.getMusicLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// QStandardPaths::PicturesLocation
  String? getPicturesLocation() {
    try {
      return xdga.getPicturesLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// QStandardPaths::GenericDataLocation
  String? getGenericDataLocation() {
    try {
      return xdga.getGenericDataLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// QStandardPaths::MoviesLocation
  String? getMoviesLocation() {
    try {
      return xdga.getMoviesLocation();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }
}
