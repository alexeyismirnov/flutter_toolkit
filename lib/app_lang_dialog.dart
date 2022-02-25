import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'dart:core';
import 'package:collection/collection.dart';

import 'restart_widget.dart';
import 'selector_dialog.dart';

class AppLangDialog extends StatelessWidget {
  final List<String> labels;
  final List<Locale> locales;

  static List<Locale> getLocales(List<String> labels) {
    var locales = <Locale>[];

    if (labels.contains("English")) locales.add(Locale('en', ''));
    if (labels.contains("Русский")) locales.add(Locale('ru', ''));
    if (labels.contains("简体中文")) locales.add(Locale('zh', 'CN'));
    if (labels.contains("繁體中文")) locales.add(Locale('zh', 'HK'));

    return locales;
  }

  AppLangDialog({this.labels = const ['English', 'Русский', '简体中文', '繁體中文']})
      : locales = AppLangDialog.getLocales(labels);

  Widget _getListItem(BuildContext context, int index) => CheckboxListTile(
      title: Text(labels[index]),
      value: context.locale == locales[index],
      onChanged: (_) {
        if (context.locale != locales[index]) {
          context.setLocale(locales[index]);
        }

        RestartWidget.restartApp(context);
      });

  @override
  Widget build(BuildContext context) => SelectorDialog(
      title: 'language',
      content: labels.mapIndexed((index, value) => _getListItem(context, index)).toList());
}
