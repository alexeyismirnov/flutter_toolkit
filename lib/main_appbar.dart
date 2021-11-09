import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_theme_dialog.dart';
import 'app_lang_dialog.dart';
import 'extensions.dart';

class MainAppbar extends StatelessWidget {
  final bool showActions;
  final String title;
  final int maxLines;
  final List<PopupMenuEntry> extraActions;

  MainAppbar(
      {this.showActions = true,
      this.title = "title",
      this.maxLines = 2,
      this.extraActions = const []});

  Widget _getActions(BuildContext context) {
    List<PopupMenuEntry> contextMenu = [
      PopupMenuItem(
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                AppLangDialog().show(context);
              },
              child: ListTile(
                  leading: const Icon(Icons.translate, size: 30.0),
                  title: Text('language').tr()))),
      PopupMenuItem(
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                AppThemeDialog().show(context);
              },
              child: ListTile(
                  leading: const Icon(Icons.color_lens, size: 30.0),
                  title: Text('bg_color').tr())))
    ];

    contextMenu.addAll(extraActions);

    return PopupMenuButton(
      icon: Icon(Icons.arrow_circle_down),
      itemBuilder: (_) => contextMenu,
    );
  }

  @override
  Widget build(BuildContext context) => SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 50.0 * maxLines,
      pinned: false,
      title: AutoSizeText(title.tr(),
          maxLines: maxLines,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6),
      centerTitle: true,
      actions: showActions ? [_getActions(context)] : []);
}
