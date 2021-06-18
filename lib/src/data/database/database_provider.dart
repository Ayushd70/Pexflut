import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'media_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE media_data(id INTEGER)",
        );
      },
      version: 1,
    );
  }
}