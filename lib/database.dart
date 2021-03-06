import 'package:home_service/models/worker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';
import 'models/user.dart';

class MyDatabase {
  MyDatabase._();
  static final MyDatabase db = MyDatabase._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
// Kahraba2y Table
        await db.execute('''
            CREATE TABLE $kahrba2yTable(
              id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT,
              isBusy INTEGER)
            ''');
// Sabbak Table
        await db.execute('''
            CREATE TABLE $sabbakTable(
              id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT
               isBusy INTEGER)
            ''');
// Naggar Table
        await db.execute('''
            CREATE TABLE $naggarTable(
             id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT
               isBusy INTEGER)
            ''');
// Delivery Table
        await db.execute('''
            CREATE TABLE $deliveryTable(
             id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT
               isBusy INTEGER)
            ''');
// user table
        await db.execute('''
            CREATE TABLE $userTable(
             id INTEGER PRIMARY KEY,
              name TEXT,
              email TEXT,
              password TEXT)
            ''');
      },
    );
  }

  insertData(data, tableName) async {
    final db = await database;
    var res = await db.insert(tableName, data.toMap());
    return res;
  }

  Future<List<Worker>> getAllWorkerData(tableName) async {
    final db = await database;
    var res = await db.query(tableName);
    List<Worker> list =
        res.isNotEmpty ? res.map((c) => Worker.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<User>> getAllUserData() async {
    final db = await database;
    var res = await db.query(userTable, limit: 1);
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  deleteData(int id, tableName) async {
    final db = await database;
    db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  updateData(data, tableName) async {
    final db = await database;
    var res = await db
        .update(tableName, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    return res;
  }
}
