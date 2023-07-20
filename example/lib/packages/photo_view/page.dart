/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/photo_view/model.dart';
import 'package:flutter_example_packages/packages/photo_view/package.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends AppStatefulWidget {
  PhotoViewPage({
    super.key,
  });

  final Package package = packagePhotoView;

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends AppState<PhotoViewPage> {
  double _heightPhotoView = 1;
  final _keyPhotoView = GlobalKey();

  @override
  void onDidChangeMetrics() {
    setState(() {
      _heightPhotoView = _getHeightPhotoView();
    });
  }

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<PhotoViewModel>(
      model: getIt<PhotoViewModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                ClipRRect(
                  borderRadius: AppRadius.small,
                  child: SizedBox(
                    key: _keyPhotoView,
                    width: double.infinity,
                    height: _heightPhotoView,
                    child: PhotoView(
                      imageProvider:
                          const AssetImage("assets/images/large_image.jpg"),
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

  double _getHeightPhotoView() {
    if (_keyPhotoView.currentContext != null) {
      RenderBox? box =
          _keyPhotoView.currentContext?.findRenderObject() as RenderBox;
      Offset position =
          box.localToGlobal(Offset.zero); //this is global position
      return MediaQuery.of(context).size.height - position.dy - 20;
    }
    return 1;
  }
}
