import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'restart_widget.dart';
import 'config_param.dart';
import 'app_theme.dart';

class AppThemeDialog extends StatelessWidget {
  final labels = ['paper', 'bright', 'dark'];

  Widget _getListItem(BuildContext context, int index) {
    final theme = ThemeType.values[index];

    return CheckboxListTile(
        title: Text(labels[index]).tr(),
        value: ConfigParam.bgcolor.val() == theme,
        onChanged: (_) {
          ConfigParam.bgcolor.set(theme);
          RestartWidget.restartApp(context);
        });
  }

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
                          Text('bg_color'.tr().toUpperCase(),
                              style: Theme.of(context).textTheme.button)
                        ])),
                _getListItem(context, 0),
                _getListItem(context, 1),
                _getListItem(context, 2),
              ])));
}
