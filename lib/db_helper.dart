// ignore_for_file: unused_local_variable

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/registration_model.dart';

class OrderAppDB {
  static final OrderAppDB instance = OrderAppDB._init();
  static Database? _database;
  OrderAppDB._init();
  static final id = 'id';
  static final cid = 'cid';
  static final fp = 'fp';
  static final os = 'os';
  static final c_d = 'c_d';
  static final cpre = 'cpre';
  static final ctype = 'ctype';
  static final hoid = 'hoid';
  static final cnme = 'cnme';
  static final ad1 = 'ad1';
  static final ad2 = 'ad2';
  static final pcode = 'pcode';
  static final ad3 = 'ad3';
  static final land = 'land';
  static final mob = 'mob';
  static final em = 'em';
  static final gst = 'gst';
  static final ccode = 'ccode';
  static final scode = 'scode';
  static final msg = 'msg';
  // int DB_VERSION = 2;
  //////////////////////////////////////

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("orderapp.db");
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
            $cpre TEXT,
            $ctype TEXT,
            $cnme TEXT,
            $ad1 TEXT,
            $ad2 TEXT,
            $ad3 TEXT,
            $pcode TEXT,
            $land TEXT,
            $mob TEXT,
            $em TEXT,
            $gst TEXT,
            $ccode TEXT,
            $scode TEXT,
            $msg TEXT,
          )
          ''');
  }

  ///////////////////////////////////////////////
  Future insertRegistrationDetails(CD cid) async {
    final db = await database;
    // var query =
    //     'INSERT INTO tableRegistration(cid, fp, os, c_d) VALUES("${cid}", "${fp}", "${os}", "${c_d}")';
    var query1 =
        'INSERT INTO registrationTable(cid, fp, os, cpre, ctype, cnme, ad1, ad2, ad3, pcode, land, mob, em, gst, ccode, scode, msg) VALUES("${cid}", "${fp}", "${os}","${cpre}", "${ctype}", "${cnme}", "${ad1}", "${ad2}", "${ad3}", "${pcode}", "${land}", "${mob}", "${em}", "${gst}", "${ccode}", "${scode}", "${msg}" )';
    var res = await db.rawInsert(query1);
    print(query1);
    print(res);
    return res;
  }

  Future close() async {
    final _db = await instance.database;
    _db.close();
  }

  /////////////////////////get all rows////////////
  // Future<List<Map<String, dynamic>>> queryAllRows() async {
  //   Database db = await instance.database;

  //   List<Map<String, dynamic>> list =
  //       await db.rawQuery('SELECT * FROM tableRegistration');
  //   print("all data ${list}");
  //   return list;
  // }

}
