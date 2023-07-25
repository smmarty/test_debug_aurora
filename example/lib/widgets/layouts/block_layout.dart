/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/theme/colors.dart';
import 'package:flutter_example_packages/widgets/base/export.dart';
import 'package:flutter_example_packages/widgets/texts/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

class BlockLayout<T extends Model> extends AppStatelessWidget {
  const BlockLayout({
    super.key,
    this.title,
    required this.model,
    required this.builder,
    this.loading,
  });

  final T model;
  final String? title;
  final bool? loading;
  final Widget Function(BuildContext context, Widget? child, T model) builder;

  @override
  Widget buildWide(
    BuildContext context,
    MediaQueryData media,
    AppLocalizations l10n,
  ) {
    return ScopedModel<T>(
      model: model,
      child: ScopedModelDescendant<T>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: title == null
                ? null
                : AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.blueGrey,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            tooltip: 'Back',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: AppColors.primary,
                    title: TextTitleLarge(
                      title!,
                      color: Colors.white,
                    ),
                  ),
            body: loading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : builder.call(context, child, model),
          );
        },
      ),
    );
  }
}
