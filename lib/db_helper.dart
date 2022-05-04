// ignore_for_file: unused_local_variable

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BarcodeScanlogDB {
  static final BarcodeScanlogDB instance = BarcodeScanlogDB._init();
  static Database? _database;
  BarcodeScanlogDB._init();
  static final id = 'id';
  static final cid = 'cid';
  static final fp = 'fp';
  static final os = 'os';
  static final cpre = 'cpre';
  static final ctype = 'ctype';
  static final hoid = 'hoid';
  static final cnme = 'cnme';
  static final ad1 = 'ad1';
  static final ad2 = 'ad2';
  static final ad3 = 'ad3';
  static final land = 'land';
  static final mob = 'mob';
  static final em = 'em';
  static final gst = 'gst';
  static final ccode = 'ccode';
  static final scode = 'scode';
  static final error = 'error';
  // int DB_VERSION = 2;
  //////////////////////////////////////

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("barcodeScan.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(
      path,
      version: 1, onCreate: _createDB,
      // onUpgrade: _upgradeDB
    );
  }

  Future _createDB(Database db, int version) async {
    ///////////////barcode store table ////////////////

    await db.execute('''
          CREATE TABLE registrationTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cid TEXT NOT NULL,
            $fp TEXT NOT NULL,
            $os TEXT NOT NULL,
          )
          ''');
  }

  ///////////////////////////////////////////////
  Future insertRegistrationDetails(
      String cid,
      String fp,
      String appType,
      String os,) async {
    final db = await database;
    // print(user_id.runtimeType);
    var query =
        'INSERT INTO tableRegistration(cid, fp, os) VALUES("${cid}", "${fp}", "${os}")';
    var res = await db.rawInsert(query);
    print(query);
    print(res);
    return res;
  }

  Future close() async {
    final _db = await instance.database;
    _db.close();
  }

  /////////////////////////get all rows////////////
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var a = "";
    Database db = await instance.database;

    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM tableScanLog');
    print("all data ${list}");
    return list;
  }

//////////////////////////////////////////////
  // deleteAllRows() async {
  //   Database db = await instance.database;
  //   await db.delete('tableScanLog');
  // }
///////////////////////////////////////////
  // Future searchIn(String barcode) async {
  //   Database db = await instance.database;

  //   List<Map<String, dynamic>> list = await db.rawQuery(
  //       'SELECT * FROM tableRegistration WHERE cid="${cid}"');
  //   if (list.isEmpty) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  //////////////////////////////////////
  // Future delete(int id) async {
  //   Database db = await instance.database;
  //   // print("id--${id}");
  //   return await db.rawDelete("DELETE FROM 'tableRegistration' WHERE $id = id");
  // }

  ////////////////////////////////////
  ///
  // Future findCount() async {
  //   Database db = await instance.database;
  //   print(await db.rawQuery('SELECT count(*) FROM tableRegistration'));
  // }

  // /////////////////select company nme////////////////
  // Future<List<Map<String, dynamic>>> getCompanyDetails() async {
  //   Database db = await instance.database;

  //   List<Map<String, dynamic>> list =
  //       await db.rawQuery('SELECT * FROM tableRegistration');
  //   print("company details-- ${list}");
  //   return list;
  // }

  // ////////////////////////////////////////////////////////
  // deleteAllRowsTableScanLog() async {
  //   Database db = await instance.database;
  //   await db.delete('tableRegistration');
  // }

  /////////////////////////////////////////////////////////
  // getColumnnames() async {
  //   Database db = await instance.database;
  //   var list =
  //       await db.query("SELECT barcode,time FROM 'tableScanLog' WHERE 1=0");
  //   return list;
  // }

  // getListOfTables() async {
  //   Database db = await instance.database;
  //   var list = await db.query('sqlite_master', columns: ['type', 'name']);
  //   print(list);
  //   list.map((e) => print(e["name"])).toList();
  //   return list;
  //   // list.forEach((row) {
  //   //   print(row.values);
  //   // });
  // }

  // getTableData(String tablename) async {
  //   Database db = await instance.database;
  //   print(tablename);
  //   var list = await db.rawQuery('SELECT * FROM $tablename');
  //   print(list);
  //   return list;
  // }

  //////////////////////////////////////////////////////

  // Future<int> queryQtyUpdate(int updatedQty, int id) async {
  //   Database db = await instance.database;
  //   print("upoadtes---${updatedQty}");
  //   // var query =
  //   //     'UPDATE tableScanLog SET qty=${updatedQty} WHERE id=${id}';
  //   var res = await db
  //       .rawUpdate('UPDATE tableScanLog SET qty=$updatedQty WHERE id=$id');
  //   return res;
  // }
}
