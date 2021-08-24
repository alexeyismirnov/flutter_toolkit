import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_theme.dart';

class RestartWidget extends StatefulWidget {
  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
    context.findAncestorStateOfType<_RestartWidgetState>();
    state.restartApp();
  }

  final Widget content;
  RestartWidget(this.content);

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    Future.delayed(const Duration(milliseconds: 500), () {
      this.setState(() {
        key = UniqueKey();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: "title".tr(),
      home: widget.content,
      theme: AppTheme.getThemeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
