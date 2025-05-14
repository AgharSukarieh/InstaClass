import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static Database? _database;

  Future<Database> initDB() async {
    String pathinto = await getDatabasesPath();
    String dbPath = '$pathinto/UserInfo.db';

    return openDatabase(dbPath, version: 6, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE User(
        id  PRIMARY KEY ,
        name TEXT,
        email TEXT,
        phone TEXT,
        lastUpdated INTEGER
      )
    ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<int?> getLastUpdatedTime() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT MAX(lastUpdated) as lastUpdated FROM User',
    );
    return result.first["lastUpdated"] as int?;
  }

  Future<List<Map<String, dynamic>>> getLocalData() async {
    final db = await database;

    return await db.query('User');
  }

  Future<int> insert(
    String id,
    String name,
    String email,
    String phone,
    int lastUpdated,
  ) async {
    final db = await database;
    return await db.insert('User', {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      "lastUpdated": lastUpdated,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertData(List<Map<String, dynamic>> data) async {
    final db = await database;
    for (var item in data) {
      await db.insert('User', {
        "id": item["id"],
        "name": item["username"],
        "email": item["email"],
        "phone": item["phoneNumber"],
        "lastUpdated":
            item["lastUpdated"] ?? DateTime.now().millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<int> updatename(String name, String id) async {
    final db = await database;
    return await db.update(
      'User',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(String name, String email, String phone, int id) async {
    final db = await database;
    return await db.update(
      'User',
      {'name': name, 'email': email, 'phone': phone},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('User', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearData() async {
    final db = await database;
    await db.delete('User');
  }
}
