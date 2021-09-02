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

  MainAppbar(
      {this.showActions = true, this.title = "title", this.maxLines = 2});

  Widget _getActions(BuildContext context) {
    List<PopupMenuEntry<String>> contextMenu = [];

    contextMenu.add(PopupMenuItem(
        value: 'language',
        child: Container(
            child: ListTile(
                leading: const Icon(Icons.translate, size: 30.0),
                title: Text('language').tr()))));

    contextMenu.add(PopupMenuItem(
        value: 'bg_color',
        child: Container(
            child: ListTile(
                leading: const Icon(Icons.color_lens, size: 30.0),
                title: Text('bg_color').tr()))));

    return PopupMenuButton<String>(
        itemBuilder: (_) => contextMenu,
        onSelected: (action) {
          switch (action) {
            case 'language':
              AppLangDialog().show(context);
              break;

            case 'bg_color':
              AppThemeDialog().show(context);
              break;
            default:
              break;
          }
        });
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
