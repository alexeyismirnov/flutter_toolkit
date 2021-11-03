import 'package:flutter/material.dart';
import 'package:flutter_toolkit/config_param.dart';

enum ThemeType { parchment, bright, dark }

class AppTheme {
  static ThemeData getThemeData(BuildContext context) {
    var theme = ConfigParam.bgcolor.val();

    switch (theme) {
      case ThemeType.parchment:
        return ThemeData(
            appBarTheme: AppBarTheme(
                titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.black,
                    ),
                backgroundColor: const Color(0xffe9c79a)),
            brightness: Brightness.light,
            cardColor: Colors.orange.shade50,
            dialogBackgroundColor: Colors.orange.shade50,
            primaryColor: const Color(0xffe9c79a),
            accentColor: Colors.black54);
        break;

      case ThemeType.bright:
        return ThemeData(
            appBarTheme: AppBarTheme(
                titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.black,
                    ),
                backgroundColor: const Color(0xffe9c79a)),
            brightness: Brightness.light,
            primaryColor: const Color(0xffe9c79a),
            accentColor: Colors.black54);
        break;

      case ThemeType.dark:
        return ThemeData(brightness: Brightness.dark);
        break;
    }
  }

  static Decoration bg_decor_1() =>
      ConfigParam.bgcolor.val() == ThemeType.parchment
          ? BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("lib/images/bg.jpg", package: "flutter_toolkit"),
                fit: BoxFit.fill,
              ),
            )
          : null;

  static Decoration bg_decor_2() =>
      ConfigParam.bgcolor.val() == ThemeType.parchment
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/images/bg2.jpg",
                      package: "flutter_toolkit"),
                  fit: BoxFit.contain,
                  repeat: ImageRepeat.repeat),
            )
          : null;

  static Decoration bg_decor_3() =>
      ConfigParam.bgcolor.val() == ThemeType.parchment
          ? BoxDecoration(
              image: DecorationImage(
              image:
                  AssetImage("lib/images/bg3.jpg", package: "flutter_toolkit"),
              fit: BoxFit.cover,
            ))
          : null;
}
