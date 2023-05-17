import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class GlobalPath {
  static late String databases;
  static late String documents;

  static Future ensureInitialized() async {
    documents = (await getApplicationDocumentsDirectory()).path;
    databases = await getDatabasesPath();
  }
}
