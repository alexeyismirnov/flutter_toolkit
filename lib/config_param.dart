import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:flutter_toolkit/app_theme.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

typedef void SubscriptionHandler<T>(T val);

class ConfigParam<T> {
  static late SharedPreferences prefs;
  static var fontSize, bgcolor, langSelected;

  String prefKey;
  final subject = PublishSubject<T>();

  static initSharedParams({double initFontSize = 20.0}) async {
    prefs = await SharedPreferences.getInstance();

    fontSize = ConfigParam<double>('fontSize', initValue: initFontSize);

    bgcolor = ConfigParam<ThemeType>('bgcolor',
        initValue: WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
            ? ThemeType.dark
            : ThemeType.parchment);

    langSelected = ConfigParam<bool>('lang_init', initValue: false);
  }

  ConfigParam(this.prefKey, {required T initValue}) {
    if (initValue != null && !exists) set(initValue);
  }

  bool get exists => prefs.getKeys().contains(prefKey);

  T val() {
    if (T == int)
      return prefs.getInt(prefKey) as T;
    else if (T == double)
      return prefs.getDouble(prefKey) as T;
    else if (T == bool)
      return prefs.getBool(prefKey) as T;
    else if (T == String)
      return prefs.getString(prefKey) as T;
    else if (T == ThemeType)
      return ThemeType.values[prefs.getInt(prefKey) ?? 0] as T;
    else
      return prefs.getStringList(prefKey) as T;
  }

  set(T val) {
    if (T == int)
      prefs.setInt(prefKey, val as int);
    else if (T == double)
      prefs.setDouble(prefKey, val as double);
    else if (T == bool)
      prefs.setBool(prefKey, val as bool);
    else if (T == String)
      prefs.setString(prefKey, val as String);
    else if (T == ThemeType)
      prefs.setInt(prefKey, (val as ThemeType).index);
    else
      prefs.setStringList(prefKey, val as List<String>);

    subject.add(val);
  }

  StreamSubscription onChange(SubscriptionHandler<T> handler) => subject.stream.listen(handler);
}
