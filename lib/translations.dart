import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:easy_localization/easy_localization.dart';

import 'dart:core';
import 'dart:async';
import 'dart:convert';

class DirectoryAssetLoader extends AssetLoader {
  String basePath;
  DirectoryAssetLoader({this.basePath});

  String getLocalePath(Locale locale) =>
      '$basePath/${locale.toStringWithSeparator(separator: "-")}/';

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    var result = Map<String, dynamic>();

    for (var filename in path.split(",")) {
      var fullPath = getLocalePath(locale) + "$filename.json";
      result.addAll(await json.decode(await rootBundle.loadString(fullPath)));
    }

    var completer = Completer<Map<String, dynamic>>();
    completer.complete(result);
    return completer.future;
  }
}

