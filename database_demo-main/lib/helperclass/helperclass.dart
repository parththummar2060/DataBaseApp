import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/modelclass.dart';

class Helper {
  Helper._();

  static final Helper helper = Helper._();
  static Database? db;
  String tableName = "employee";
  String colId = "id";
  String colName = "name";
  String colAge = "age";
  String colSalary = "salary";
  String colRole = "role";
  String colCmpName = "cmp_name";
  String colCity = "city";
  String colImage = "image";

  //create database
  Future<Database?> initDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'flutter.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int i) async {
      String query =
          "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT,$colAge INTEGER, $colSalary INTEGER,role TEXT,$colCmpName TEXT, $colCity TEXT , $colImage BLOB);";
      await db.execute(query);
    });
    return db;
  }

  //Raw Insert
  Future<int> insertRaw({required Detail data}) async {
    await initDb();
    String query =
        "INSERT INTO $tableName($colName, $colAge,$colSalary,$colRole,$colCmpName,$colCity) VALUES(?,?,?,?,?,?);";
    List args = [
      data.name,
      data.age,
      data.salary,
      data.role,
      data.cmpName,
      data.city
    ];
    int i = await db!.rawInsert(query, args);
    return i;
  }

  //Read Data || Fetch Data
  Future<List<Detail>> showData() async {
    db = await initDb();

    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Detail> allData = data.map((e) => Detail.fromMap(e)).toList();

    return allData;
  }

  //Update Data
  updateData({required Detail data}) async {
    db = await initDb();

    String query =
        "UPDATE $tableName SET $colName=? ,$colAge=? , $colCity =? ,$colCmpName=?, $colRole=? ,$colSalary=? WHERE $colId= ?;";
    List arg = [
      data.name,
      data.age,
      data.city,
      data.cmpName,
      data.role,
      data.salary,
      data.id
    ];

    db!.rawUpdate(query, arg);
  }

  //Delete Data
  deleteData({required int? id}) async {
    db = await initDb();

    String query = "DELETE FROM $tableName WHERE $colId=?";

    List arg = [id];
    db!.rawDelete(query, arg);
  }

  //all Data Delete
  deleteAllData() async {
    db = await initDb();

    String query = tableName;

    db!.delete(query);
  }

  //update image
  updateImage({required Uint8List image, required int id}) async {
    db = await initDb();

    String query = "UPDATE $tableName SET $colImage= ? WHERE $colId = ?";
    List arg = [image, id];
    db!.rawUpdate(query, arg);
  }
}
