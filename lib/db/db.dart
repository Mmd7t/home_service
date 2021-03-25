import 'package:home_service/models/worker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

class DB {
  DB._();
  static final DB db = DB._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
/*------------------------------------  Kahraba2y DB Table  ------------------------------------*/
        await db.execute('''
            CREATE TABLE $kahrba2yTable(
              id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT)
            ''');
/*------------------------------------  Sabbak DB Table  ------------------------------------*/
        await db.execute('''
            CREATE TABLE $sabbakTable(
              id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT)
            ''');
/*------------------------------------  Naggar DB Table  ------------------------------------*/
        await db.execute('''
            CREATE TABLE $naggarTable(
             id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT)
            ''');
/*------------------------------------  Delivery DB Table  ------------------------------------*/
        await db.execute('''
            CREATE TABLE $deliveryTable(
             id INTEGER PRIMARY KEY,
              name TEXT,
              phoneNum TEXT,
              dateTime TEXT)
            ''');
/*------------------------------------  Delivery DB Table  ------------------------------------*/
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

  /*-----------------------  Insert into Rent DB Table ---------------------------*/

  insertWorkerData(Worker data, tableName) async {
    final db = await database;
    var res = await db.insert(tableName, data.toMap());
    return res;
  }

  /*-----------------------  Read from Rent DB Table  ---------------------------*/

  Future<List<Worker>> getAllWorkerData(tableName) async {
    final db = await database;
    var res = await db.query(tableName);
    List<Worker> list =
        res.isNotEmpty ? res.map((c) => Worker.fromMap(c)).toList() : [];
    return list;
  }

  /*-----------------------  Update Object in Rent DB Table  ---------------------------*/

  updateWorkerData(Worker data, tableName) async {
    final db = await database;
    var res = await db
        .update(tableName, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    return res;
  }

  /*-----------------------  Delete Object from Rent DB Table  ---------------------------*/

  deleteWorkerData(int id, tableName) async {
    final db = await database;
    db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
