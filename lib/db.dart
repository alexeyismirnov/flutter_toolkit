import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'dart:typed_data';
import 'dart:core';
import 'dart:async';
import 'dart:io';

import 'global_path.dart';

class DB {
  static Future prepare({String basename, String filename}) async {
    var path = join(GlobalPath.databases, filename);

    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join(basename, filename));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);
  }

  static Future<Database> open(String filename, {String dirname}) async {
    var path = join(dirname ?? GlobalPath.databases, filename);
    var db = await openDatabase(path, readOnly: true);

    return db;
  }
}
