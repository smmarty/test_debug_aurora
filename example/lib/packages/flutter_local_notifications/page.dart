/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/base/di/app_di.dart';
import 'package:flutter_example_packages/base/package/package.dart';
import 'package:flutter_example_packages/packages/flutter_local_notifications/model.dart';
import 'package:flutter_example_packages/packages/flutter_local_notifications/package.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/blocks/block_alert.dart';
import 'package:flutter_example_packages/widgets/blocks/block_info_package.dart';
import 'package:flutter_example_packages/widgets/layouts/block_layout.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FlutterLocalNotificationsPage extends AppStatefulWidget {
  FlutterLocalNotificationsPage({
    super.key,
  });

  final Package package = packageFlutterLocalNotifications;

  @override
  State<FlutterLocalNotificationsPage> createState() =>
      _FlutterLocalNotificationsPageState();
}

class _FlutterLocalNotificationsPageState
    extends AppState<FlutterLocalNotificationsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return BlockLayout<FlutterLocalNotificationsModel>(
      model: getIt<FlutterLocalNotificationsModel>(),
      title: widget.package.key,
      builder: (context, child, model) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlockInfoPackage(widget.package),
                BlockAlert(model.error),
                if (!model.isError)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: l10n.flutterLocalNotificationsHintTitle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _bodyController,
                        decoration: InputDecoration(
                          hintText: l10n.flutterLocalNotificationsHintBody,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => model.showNotification(
                            title: _titleController.text.isEmpty
                                ? l10n.flutterLocalNotificationsHintTitle
                                : _titleController.text,
                            body: _bodyController.text.isEmpty
                                ? l10n.flutterLocalNotificationsHintBody
                                : _bodyController.text,
                          ),
                          child: TextBodyLarge(
                            l10n.flutterLocalNotificationsBtn,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
