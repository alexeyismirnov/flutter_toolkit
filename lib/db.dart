import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:typed_data';
import 'dart:core';
import 'dart:async';
import 'dart:io';

import 'global_path.dart';

class DB {
  static Future prepare({required String path}) async {
    final filename = basename(path);
    final destPath = join(GlobalPath.databases, filename);
    await deleteDatabase(destPath);

    try {
      await Directory(dirname(destPath)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    final file = File(destPath);
    await file.writeAsBytes(bytes, flush: true);
  }

  static Future<Database> open(String filename, {String? dirname}) async {
    var path = join(dirname ?? GlobalPath.databases, filename);
    var db = await openDatabase(path, readOnly: true);

    return db;
  }
}

extension SqfliteExt on Sqflite {
  static String? firstStringValue(List<Map<String, Object?>> list) =>
      list.firstOrNull?.values.firstOrNull.toString();
}

