import 'database_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class AppDatabase {
  Future<void> insertMediaData(int id) async {
    final Database db = await DBProvider.db.database;
    var count = firstIntValue(await db.query('media_data',
        columns: ['COUNT(*)'], where: 'id = ?', whereArgs: [id]));
    if (count > 0) return null;

    await db.insert(
      'media_data',
      {'id': id},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<int>> mediaData() async {
    final Database db = await DBProvider.db.database;

    final List<Map<String, dynamic>> maps = await db.query('media_data');

    return List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<void> deleteMediaData(int id) async {
    final db = await DBProvider.db.database;

    await db.delete(
      'media_data',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<bool> isContain(int id) async {
    final db = await DBProvider.db.database;
    var count = firstIntValue(await db.query('media_data',
        columns: ['COUNT(*)'], where: 'id = ?', whereArgs: [id]));
    return count > 0;
  }
}

final AppDatabase appDatabase = AppDatabase();