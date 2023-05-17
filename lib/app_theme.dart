import 'package:flutter/material.dart';
import 'package:flutter_toolkit/config_param.dart';

enum ThemeType { parchment, bright, dark }

class AppTheme {
  static ThemeData getThemeData(BuildContext context) {
    var theme = ConfigParam.bgcolor.val();

    switch (theme) {
      case ThemeType.parchment:
        return ThemeData(
            sliderTheme: SliderThemeData(
                activeTrackColor: const Color(0xffedd0ab),
                inactiveTrackColor:Colors.grey.shade400 ,
                thumbColor: const Color(0xffdfa66d)),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
                backgroundColor: const Color(0xffe9c79a)),
            brightness: Brightness.light,
            cardColor: Colors.orange.shade50,
            dialogBackgroundColor: Colors.orange.shade50,
            primaryColor: const Color(0xffe9c79a),
            secondaryHeaderColor: const Color(0xff804000),
            hintColor: Colors.black54);

      case ThemeType.bright:
        return ThemeData(
            sliderTheme: SliderThemeData(
                activeTrackColor: const Color(0xffedd0ab),
                inactiveTrackColor:Colors.grey.shade400 ,
                thumbColor: const Color(0xffdfa66d)),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
                backgroundColor: const Color(0xffe9c79a)),
            brightness: Brightness.light,
            primaryColor: const Color(0xffe9c79a),
            secondaryHeaderColor: const Color(0xff804000),
            hintColor: Colors.black54);

      case ThemeType.dark:
        return ThemeData(
            appBarTheme: AppBarTheme(
                titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                backgroundColor: Colors.grey.shade800),
            secondaryHeaderColor: const Color(0xffe9c79a),
            brightness: Brightness.dark);

      default:
        return ThemeData();
    }
  }

  static BoxDecoration? bg_decor_1() => ConfigParam.bgcolor.val() == ThemeType.parchment
      ? BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/bg.jpg", package: "flutter_toolkit"),
            fit: BoxFit.fill,
          ),
        )
      : null;

  static BoxDecoration? bg_decor_2() => ConfigParam.bgcolor.val() == ThemeType.parchment
      ? BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/images/bg2.jpg", package: "flutter_toolkit"),
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat),
        )
      : null;

  static BoxDecoration? bg_decor_3() => ConfigParam.bgcolor.val() == ThemeType.parchment
      ? BoxDecoration(
          image: DecorationImage(
          image: AssetImage("lib/images/bg3.jpg", package: "flutter_toolkit"),
          fit: BoxFit.cover,
        ))
      : null;
}
