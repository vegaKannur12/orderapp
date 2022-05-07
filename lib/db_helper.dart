// ignore_for_file: unused_local_variable

import 'package:orderapp/model/accounthead_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/registration_model.dart';
import 'model/staffarea_model.dart';
import 'model/staffdetails_model.dart';

class OrderAppDB {
  static final OrderAppDB instance = OrderAppDB._init();
  static Database? _database;
  OrderAppDB._init();
  /////////registration fields//////////
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

/////////// staff details /////////////
  static final sid = 'sid';
  static final sname = 'sname';
  static final uname = 'uname';
  static final pwd = 'pwd';
  static final ph = 'ph';
  // int DB_VERSION = 2;

  //////////////Staff area details////////////////////////
  static final aid = 'aid';
  static final aname = 'aname';

  //////////////account heads///////////////////////////////
  static final code = 'code';
  static final hname = 'hname';
  static final gtype = 'gtype';
  static final ac_ad1 = 'ac_ad1';
  static final ac_ad2 = 'ac_ad2';
  static final ac_ad3 = 'ac_ad3';
  static final area_id = 'area_id';
  static final phn = 'phn';
  static final ba = 'ba';
  static final ri = 'ri';
  static final rc = 'rc';
  static final ht = 'ht';
  static final mo = 'mo';
  static final ac_gst = 'ac_gst';
  static final ac = 'ac';
  static final cag = 'cag';

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
    print("table created");
    ///////////////orderapp store table ////////////////
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
            $msg TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE staffDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $sid TEXT NOT NULL,
            $sname TEXT,
            $uname TEXT,
            $pwd TEXT,
            $ad1 TEXT,
            $ad2 TEXT,
            $ad3 TEXT,
            $ph TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE areaDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $aid TEXT NOT NULL,
            $aname TEXT
          )
          ''');
    ////////////////account_haed table///////////////////
    await db.execute('''
          CREATE TABLE accountHeadsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $code TEXT NOT NULL,
            $hname TEXT NOT NULL,
            $gtype TEXT NOT NULL,
            $ac_ad1 TEXT,
            $ac_ad2 TEXT,
            $ac_ad3 TEXT,
            $area_id TEXT,
            $phn TEXT,
            $ba TEXT,
            $ri TEXT,
            $rc TEXT,
            $ht TEXT,
            $mo TEXT,
            $ac_gst TEXT,
            $ac TEXT,
            $cag TEXT
          )
          ''');
  }

  ///////////////////// registration details insertion //////////////////////////
  Future insertRegistrationDetails(RegistrationData data) async {
    final db = await database;
    var query1 =
        'INSERT INTO registrationTable(cid, fp, os, cpre, ctype, cnme, ad1, ad2, ad3, pcode, land, mob, em, gst, ccode, scode, msg) VALUES("${data.cid}", "${data.fp}", "${data.os}","${data.c_d![0].cpre}", "${data.c_d![0].ctype}", "${data.c_d![0].cnme}", "${data.c_d![0].ad1}", "${data.c_d![0].ad2}", "${data.c_d![0].ad3}", "${data.c_d![0].pcode}", "${data.c_d![0].land}", "${data.c_d![0].mob}", "${data.c_d![0].em}", "${data.c_d![0].gst}", "${data.c_d![0].ccode}", "${data.c_d![0].scode}", "${data.msg}" )';
    var res = await db.rawInsert(query1);
    // print(query1);
    // print(res);
    return res;
  }

////////////////////// staff details insertion /////////////////////
  Future insertStaffDetails(StaffDetails sdata) async {
    final db = await database;
    var query2 =
        'INSERT INTO staffDetailsTable(sid, sname, uname, pwd, ad1, ad2, ad3, ph) VALUES("${sdata.sid}", "${sdata.sname}", "${sdata.unme}", "${sdata.pwd}", "${sdata.ad1}", "${sdata.ad2}", "${sdata.ad3}", "${sdata.ph}")';
    var res = await db.rawInsert(query2);
    print(query2);
    // print(res);
    return res;
  }

////////////////////// staff area details insertion /////////////////////
  Future insertStaffAreaDetails(StaffArea adata) async {
    final db = await database;
    var query3 =
        'INSERT INTO areaDetailsTable(aid, aname) VALUES("${adata.aid}", "${adata.anme}")';
    var res = await db.rawInsert(query3);
    print(query3);
    print(res);
    return res;
  }

  Future close() async {
    final _db = await instance.database;
    _db.close();
  }

  /////////////////////////ustaff login authentication////////////
  Future<String> selectStaff(String uname, String pwd) async {
    String result = "";
    print("uname---Password----${uname}--${pwd}");
    Database db = await instance.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM staffDetailsTable');
    for (var staff in list) {
      print(
          "staff['uname'] & staff['pwd']------------------${staff['uname']}--${staff['pwd']}");
      if (uname == staff["uname"] && pwd == staff["pwd"]) {
        print("ok");
        result = "success";
        break;
      } else {
        result = "failed";
      }
    }
    print("res===${result}");

    print("all data ${list}");
    return result;
  }

  /////////////////////////account heads insertion///////////////////////////////
  Future insertAccoundHeads(AccountHead accountHead) async {
    final db = await database;
    var query =
        'INSERT INTO accountHeadsTable(code, hname, gtype, ac_ad1, ac_ad2, ac_ad3, area_id, phn, ba, ri, rc, ht, mo, ac_gst, ac, cag) VALUES("${accountHead.code}", "${accountHead.hname}", "${accountHead.gtype}", "${accountHead.ad1}", "${accountHead.ad2}", "${accountHead.ad3}", "${accountHead.aid}", "${accountHead.ph}", "${accountHead.ba}", "${accountHead.ri}", "${accountHead.rc}", "${accountHead.ht}", "${accountHead.mo}", "${accountHead.gst}", "${accountHead.ac}", "${accountHead.cag}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

  ///////////////////////clear staffDetails///////////////////////////////
  // Future deleteStaffdetails() async {
  //   final db = await database;
  //   var res =await db.delete("staffDetailsTable");
  //   // var res = await db.delete(query);
  //   print(res);
  //   return res;
  // }
 Future deleteStaffdetails() async {
    Database db = await instance.database;
    await db.delete('staffDetailsTable');
  }

  ////////////////////////////////////////////////////////////////////
  getListOfTables() async {
    Database db = await instance.database;
    var list = await db.query('sqlite_master', columns: ['type', 'name']);
    print(list);
    list.map((e) => print(e["name"])).toList();
    return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  getTableData(String tablename) async {
    Database db = await instance.database;
    print(tablename);
    var list = await db.rawQuery('SELECT * FROM $tablename');
    print(list);
    return list;
    // list.map((e) => print(e["name"])).toList();
    // return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }
}
