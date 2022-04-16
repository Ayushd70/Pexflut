import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'media_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE media_data(mediaTypeCode INTERGER, mediaID INTEGER)",
        );
      },
      version: 1,
    );
  }
}
