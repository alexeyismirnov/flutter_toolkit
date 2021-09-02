import 'package:flutter/material.dart';
import 'restart_widget.dart';

import 'package:easy_localization/easy_localization.dart';

class AppLangDialog extends StatelessWidget {
  final labels = ['English', 'Русский', '简体中文', '正體中文'];
  final locales = [
    Locale('en', ''),
    Locale('ru', ''),
    Locale('zh', 'CN'),
    Locale('zh', 'HK')
  ];

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
  Widget build(BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.all(5.0),
      content: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('language'.tr().toUpperCase(),
                              style: Theme.of(context).textTheme.button)
                        ])),
                _getListItem(context, 0),
                _getListItem(context, 1),
                _getListItem(context, 2),
                _getListItem(context, 3),
              ])));
}
