import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'restart_widget.dart';
import 'config_param.dart';
import 'app_theme.dart';
import 'selector_dialog.dart';

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
  Widget build(BuildContext context) => SelectorDialog(title: 'bg_color', content: [
        _getListItem(context, 0),
        _getListItem(context, 1),
        _getListItem(context, 2),
      ]);
}
