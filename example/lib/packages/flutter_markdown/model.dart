/*
 * Copyright (C) 2023 Open Mobile Platform LLC.
 */
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

/// Model for [FlutterMarkdownPage]
class FlutterMarkdownModel extends Model {
  /// Get [ScopedModel]
  static FlutterMarkdownModel of(BuildContext context) =>
      ScopedModel.of<FlutterMarkdownModel>(context);

  final String data = '''
An h1 header
============

Paragraphs are separated by a blank line.

2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists
look like:

  * this one
  * that one
  * the other one

Note that --- not considering the asterisk --- the actual text
content starts at 4-columns in.

> Block quotes are
> written like so.
>
> They can span multiple paragraphs,
> if you like.

Use 3 dashes for an em-dash. Use 2 dashes for ranges (ex., "it's all
in chapters 12--14"). Three dots ... will be converted to an ellipsis.
Unicode is supported. ☺

## Image

![Minion](https://github.com/keygenqt/awesome-aurora/blob/master/docs/assets/images/common/aurora.png?raw=true)
  ''';
}
