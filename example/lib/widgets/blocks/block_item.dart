// SPDX-FileCopyrightText: Copyright 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Block list item
class BlockItem<T> extends AppStatelessWidget {
  const BlockItem({
    super.key,
    this.title,
    this.desc,
    this.value,
    this.future,
    this.stream,
    this.builder,
  });

  final String? title;
  final String? desc;
  final T? value;
  final Stream<T>? stream;
  final Future<T>? future;
  final Function(T)? builder;

  AsyncWidgetBuilder<T?> get widgetBuilder =>
      (BuildContext context, AsyncSnapshot<T?> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: title != null,
              child: Column(
                children: [
                  TextTitleLarge(title ?? ''),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Visibility(
              visible: desc != null,
              child: Column(
                children: [
                  TextBodyMedium(desc ?? ''),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (snapshot.hasData)
              TextBodyMedium(
                builder == null
                    ? snapshot.data.toString()
                    : builder?.call(snapshot.data as T),
                fontWeight: FontWeight.bold,
              ),
            if (!snapshot.hasData)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                  strokeWidth: 2,
                ),
              ),
            const SizedBox(height: 20),
          ],
        );
      };

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    if (stream != null) {
      return StreamBuilder(
        stream: stream,
        builder: widgetBuilder,
      );
    }
    if (future != null) {
      return FutureBuilder(
        future: future,
        builder: widgetBuilder,
      );
    }
    return FutureBuilder(
      future: Future.value(value),
      builder: widgetBuilder,
    );
  }
}
