import 'database_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class AppDatabase {
  Future<void> insertMediaData(int mediaTypeCode, int mediaID) async {
    final Database db = await DBProvider.db.database;
    var count = firstIntValue(await db.query(
          'media_data',
          columns: ['COUNT(*)'],
          where: 'mediaID = ?',
          whereArgs: [mediaID],
        )) ??
        0;
    if (count > 0) return null;

    await db.insert(
      'media_data',
      {'mediaTypeCode': mediaTypeCode, 'mediaID': mediaID},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<List<int>>> mediaData() async {
    final Database db = await DBProvider.db.database;

    final List<Map<String, dynamic>> maps = await db.query('media_data');

    return List.generate(maps.length, (i) {
      return [maps[i]['mediaTypeCode'], maps[i]['mediaID']];
    });
  }

  Future<void> deleteMediaData(int mediaTypeCode, int mediaID) async {
    final db = await DBProvider.db.database;

    await db.delete(
      'media_data',
      where: "mediaTypeCode = ? AND mediaID = ?",
      whereArgs: [mediaTypeCode, mediaID],
    );
  }

  Future<bool> isContain(int mediaTypeCode, int mediaID) async {
    final db = await DBProvider.db.database;
    var count = firstIntValue(await db.query(
          'media_data',
          columns: ['COUNT(*)'],
          where: 'mediaTypeCode = ? AND mediaID = ?',
          whereArgs: [mediaTypeCode, mediaID],
        )) ??
        0;
    return count > 0;
  }
}

final AppDatabase appDatabase = AppDatabase();
