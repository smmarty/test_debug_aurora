// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart' as provider;
import 'package:scoped_model/scoped_model.dart';
import 'package:universal_io/io.dart';

/// Model for [PathProviderPage]
class PathProviderModel extends Model {
  /// Get [ScopedModel]
  static PathProviderModel of(BuildContext context) =>
      ScopedModel.of<PathProviderModel>(context);

  /// Error
  String? _error;

  /// Public error
  String? get error => _error;

  /// Public is error
  bool get isError => _error != null;

  /// Directory where the application may place application support files.
  Future<Directory?> getApplicationSupportDirectory() async {
    try {
      return await provider.getApplicationSupportDirectory();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Directory location where user-specific non-essential (cached) data should be written.
  Future<Directory?> getTemporaryDirectory() async {
    try {
      return await provider.getTemporaryDirectory();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Directory containing user document files.
  Future<Directory?> getApplicationDocumentsDirectory() async {
    try {
      return await provider.getApplicationDocumentsDirectory();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// Directory for user's downloaded files.
  Future<Directory?> getDownloadsDirectory() async {
    try {
      return await provider.getDownloadsDirectory();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// There is no concept of External in Aurora OS, but this interface allows you to get the StorageDirectory.pictures directory.
  Future<List<Directory>?> getExternalStorageDirectoriesPictures() async {
    try {
      return await provider.getExternalStorageDirectories(
        type: StorageDirectory.pictures,
      );
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// There is no concept of External in Aurora OS, but this interface allows you to get the StorageDirectory.music directory.
  Future<List<Directory>?> getExternalStorageDirectoriesMusic() async {
    try {
      return await provider.getExternalStorageDirectories(
        type: StorageDirectory.music,
      );
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }

  /// There is no concept of External in Aurora OS, but this interface allows you to get the StorageDirectory.movies directory.
  Future<List<Directory>?> getExternalStorageDirectoriesMovies() async {
    try {
      return await provider.getExternalStorageDirectories(
        type: StorageDirectory.movies,
      );
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return null;
  }
}
