import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:typed_data';
import 'dart:core';
import 'dart:async';
import 'dart:io';

class DB {
  static Future prepare(String filename) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, filename);

    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets/db", filename));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(path).writeAsBytes(bytes, flush: true);
  }

  static Future<Database> open(String filename) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, filename);
    var db = await openDatabase(path, readOnly: true);

    return db;
  }
}
