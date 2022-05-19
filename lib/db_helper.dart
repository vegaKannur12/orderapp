// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/model/accounthead_model.dart';
import 'package:orderapp/model/productdetails_model.dart';
import 'package:orderapp/model/productsCategory_model.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/productCompany_model.dart';
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
  static final area = 'area';

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

  /////////////productdetails//////////

  static final ean = 'ean';
  static final item = 'item';
  static final unit = 'unit';
  static final categoryId = 'categoryId';
  static final companyId = 'companyId';
  static final stock = 'stock';
  static final hsn = 'hsn';
  static final tax = 'tax';
  static final prate = 'prate';
  static final mrp = 'mrp';
  static final cost = 'cost';
  static final rate1 = 'rate1';
  static final rate2 = 'rate2';
  static final rate3 = 'rate3';
  static final rate4 = 'rate4';
  static final priceflag = 'priceflag';

  ////////////////prooduct category///////////////
  static final cat_id = 'cat_id';
  static final cat_name = 'cat_name';
  ////////////////// product company ////////////////
  static final comid = 'comid';
  static final comanme = 'comanme';
///////////////// ORDER MASTER ////////////////////
  static final order_id = 'order_id';

  static final ordernum = 'ordernum';
  static final orderdatetime = 'orderdatetime';
  static final customerid = 'customerid';
  static final userid = 'userid';
  static final areaid = 'areaid';
  static final status = 'status';
/////////////////// cart table/////////////
  static final cartdatetime = 'cartdatetime';
  static final cartrowno = 'cartrowno';
  static final qty = 'qty';
  static final rate = 'rate';
  static final totalamount = 'totalamount';
  static final cstatus = 'cstatus';
  static final ordrow_num = 'ordrow_num';
  static final itemName = 'itemName';
  static final numberof_items = 'numberof_items';
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
            $ph TEXT,
            $area TEXT
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

    await db.execute('''
          CREATE TABLE productDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $code TEXT NOT NULL,
            $ean TEXT,
            $item TEXT,
            $unit TEXT,
            $categoryId TEXT,
            $companyId TEXT,
            $stock TEXT,
            $hsn TEXT,
            $tax TEXT,
            $prate TEXT,
            $mrp TEXT,
            $cost TEXT,
            $rate1 TEXT,
            $rate2 TEXT,
            $rate3 TEXT,
            $rate4 TEXT,
            $priceflag TEXT

          )
          ''');
    //////////////////////////products category////////////////////
    await db.execute('''
          CREATE TABLE productsCategory (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cat_id TEXT NOT NULL,
            $cat_name TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE companyTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $comid TEXT NOT NULL,
            $comanme TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE orderMasterTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $order_id INTEGER,
            $orderdatetime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $userid TEXT,
            $areaid TEXT,
            $status INTEGER

          )
          ''');

    await db.execute('''
          CREATE TABLE orderDetailTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $order_id INTEGER,
            $numberof_items INTEGER,
            $code TEXT,
            $qty INTEGER,
            $rate TEXT,
            $status INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE orderBagTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $itemName TEXT NOT NULL,
            $cartdatetime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $cartrowno INTEGER,
            $code TEXT,
            $qty INTEGER,
            $rate TEXT,
            $totalamount TEXT,
            $cstatus INTEGER
          )
          ''');
  }

  ///////////////////////////////////////////////////////////

  ////////////// cart order ////////////////////////////
  // Future insertorderMasterTable(String ordernum, String orderdate, String os,
  //     String customerid, String userid, String areaid, int status) async {
  //   final db = await database;
  //   var query2 =
  //       'INSERT INTO orderMasterTable(ordernum, orderdatetime, os, customerid, userid, areaid, mstatus) VALUES("${ordernum}", "${orderdate}", "${os}", "${customerid}", "${userid}", "${areaid}", ${status})';
  //   var res = await db.rawInsert(query2);
  //   print(query2);
  //   // print(res);
  //   return res;
  // }

  //////////////////////////////////////////////
  Future insertorderBagTable(
      String itemName,
      String cartdatetime,
      String os,
      String customerid,
      int cartrowno,
      String code,
      int qty,
      String rate,
      String totalamount,
      int cstatus) async {
    print("os--$os");
    final db = await database;

    var query2 =
        'INSERT INTO orderBagTable(itemName, cartdatetime, os, customerid, cartrowno, code, qty, rate, totalamount, cstatus) VALUES("${itemName}","${cartdatetime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}", "${totalamount}", $cstatus)';

    var res = await db.rawInsert(query2);
    print(query2);
    print(res);
    return res;
  }

  /////////////////////// order master table insertion//////////////////////
  Future insertorderMasterandDetailsTable(
    String orderdate,
    String os,
    String customerid,
    String userid,
    String areaid,
    int status,
  ) async {
    final db = await database;
    List<Map<String, dynamic>> res = await db.rawQuery(
        'SELECT  code, qty, rate FROM orderBagTable WHERE customerid="${customerid}" AND os = "${os}"');
    if (res.length > 0) {
      for (var item in res) {
        String code = item["code"];
        int qty = item["qty"];
        String rate = item["rate"];
        
        var query2 =
            'INSERT INTO orderDetailTable(order_id,code, qty, rate, status) VALUES("${order_id}","${code}", ${qty}, "${rate}", ${status})';
        var res2 = await db.rawInsert(query2);
      }
    }

    var query3 =
        'INSERT INTO orderMasterTable(order_id, orderdatetime, os, customerid, userid, areaid, status) VALUES("${order_id}", "${orderdate}", "${os}", "${customerid}", "${userid}", "${areaid}", ${status})';

    var res1 = await db.rawInsert(query3);
    print(query3);
    // print(res);
    return res;
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

////////////////////select from orderBagTable//////////////////////

  Future<List<Map<String, dynamic>>> getOrderBagTable(
      String customerId, String os) async {
    print("enteredcustomerId---${customerId}");
    // Provider.of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(res);
    return res;
  }

////////////////////// staff details insertion /////////////////////
  Future insertStaffDetails(StaffDetails sdata) async {
    final db = await database;
    var query2 =
        'INSERT INTO staffDetailsTable(sid, sname, uname, pwd, ad1, ad2, ad3, ph, area) VALUES("${sdata.sid}", "${sdata.sname}", "${sdata.unme}", "${sdata.pwd}", "${sdata.ad1}", "${sdata.ad2}", "${sdata.ad3}", "${sdata.ph}", "${sdata.area}")';
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

//////////////////////////product details ///////////////////////////////////////////
  Future insertProductDetails(ProductDetails pdata) async {
    final db = await database;
    var query3 =
        'INSERT INTO productDetailsTable(code, ean, item, unit, categoryId, companyId, stock, hsn, tax, prate, mrp, cost, rate1, rate2, rate3, rate4, priceflag) VALUES("${pdata.code}", "${pdata.ean}", "${pdata.item}", "${pdata.unit}", "${pdata.categoryId}", "${pdata.companyId}", "${pdata.stock}", "${pdata.hsn}", "${pdata.tax}", "${pdata.prate}", "${pdata.mrp}", "${pdata.cost}", "${pdata.rate1}", "${pdata.rate2}", "${pdata.rate3}", "${pdata.rate4}", "${pdata.priceFlag}")';
    var res = await db.rawInsert(query3);
    // print(query3);
    // print(res);
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

  ////////////////////////////product category insertion//////////////
  Future insertProductCategory(
      ProductsCategoryModel productsCategoryModel) async {
    final db = await database;
    var query =
        'INSERT INTO productsCategory(cat_id, cat_name) VALUES("${productsCategoryModel.cid}", "${productsCategoryModel.canme}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

////////////////////////////////// product company ///////////////////////
  Future insertProductCompany(ProductCompanymodel productsCompanyModel) async {
    final db = await database;
    var query =
        'INSERT INTO companyTable(comid, comanme) VALUES("${productsCompanyModel.comid}", "${productsCompanyModel.comanme}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

////////////////////////////////////////////////
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

  //////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getArea(String staffName) async {
    List<Map<String, dynamic>> list = [];
    String result = "";
    print("staffName---${staffName}");
    Database db = await instance.database;
    var area = await db.rawQuery(
        'SELECT area FROM staffDetailsTable WHERE sname="${staffName}"');
    if (area[0]["area"] == "") {
      list = await db.rawQuery('SELECT * FROM areaDetailsTable');
    }

    print("res===${result}");
    print("area===${area}");
    print("area---List ${list}");
    return list;
  }

  //////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getCustomer(String aid) async {
    print("enteredaid---${aid}");
    // Provider.of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var hname = await db.rawQuery(
        'SELECT  hname,code FROM accountHeadsTable WHERE area_id="${aid}"');
    print('SELECT  hname,code FROM accountHeadsTable WHERE area_id="${aid}');
    print("hname===${hname}");
    return hname;
  }

  ///////////////////////////////////////////////////////////////

  getItems(String product) async {
    print("product---${product}");
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT A.item, A.ean, A.rate1,A.code FROM productDetailsTable A WHERE A.code || A.item LIKE '%$product%'");

    print("SELECT * FROM productDetailsTable WHERE item LIKE '$product%'");
    print("items=================${res}");
    return res;
  }

  //////////////////////////////////////////////////////////////
  getOrderNo() async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT os FROM registrationTable");
    print(res);
    print("SELECT os FROM registrationTable");
    return res;
  }

  /////////////////////////max of from table//////////////////////
  // getMaxOfFieldValue(String os, String customerId) async {
  //   var res;
  //   int max;
  //   print("customerid---$customerId");
  //   Database db = await instance.database;
  //   var result = await db.rawQuery(
  //       "SELECT * FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //   print("result---$result");
  //   if (result != null && result.isNotEmpty) {
  //     print("if");
  //     res = await db.rawQuery(
  //         "SELECT MAX(cartrowno) max_val FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //     max = res[0]["max_val"] + 1;
  //     print(
  //         "SELECT MAX(cartrowno) max_val FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //   } else {
  //     print("else");
  //     max = 1;
  //   }
  //   print(res);
  //   return max;
  //   // Database db = await instance.database;
  //   // var res=db.rawQuery("SELECT (IFNULL(MAX($field),0) +1) FROM $table WHERE os='LF'");
  //   // print(res);
  //   // return res;
  // }

  ////////////////////////////sum of the product /////////////////////////////////
  gettotalSum(String os, String customerId) async {
    // double sum=0.0;
    String sum;
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT * FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");

    if (result != null && result.isNotEmpty) {
      List<Map<String, dynamic>> res = await db.rawQuery(
          "SELECT SUM(totalamount) s FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
      sum = res[0]["s"].toString();
      print("sum from db----$sum");
    } else {
      sum = "0.0";
    }

    return sum;
  }

  ////////////// delete//////////////////////////////////////
  deleteFromOrderbagTable(int cartrowno, String customerId) async {
    var res1;
    Database db = await instance.database;
    print("DELETE FROM 'orderBagTable' WHERE cartrowno = $cartrowno");
    var res = await db.rawDelete(
        "DELETE FROM 'orderBagTable' WHERE cartrowno = $cartrowno AND customerid='$customerId'");
    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM orderBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    return res1;
  }

  /////////////////////////update qty///////////////////////////////////
  updateQtyOrderBagTable(
      String qty, int cartrowno, String customerId, String rate) async {
    Database db = await instance.database;
    var res1;
    double rate1 = double.parse(rate);
    int updatedQty = int.parse(qty);
    double amount = (rate1 * updatedQty);
    print("amoiunt-----$amount");
    print("updatedqty----$updatedQty");
    // gettotalSum(String os, String customerId);
    var res = await db.rawUpdate(
        'UPDATE orderBagTable SET qty=$updatedQty , totalamount="${amount}" WHERE cartrowno=$cartrowno AND customerid="$customerId"');
    print("response-------$res");

    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM orderBagTable WHERE customerid='$customerId'");
      print(res1);
    }

    return res1;
  }

  /////////////////////////////////////////////////////////////////////
  deleteFromTableCommonQuery(String table, String os, String customerId) async {
    Database db = await instance.database;
    await db.rawDelete(
        'DELETE FROM $table WHERE os="$os" AND customerid="$customerId"');
  }

  /////////////////////////////////////////////////////////////////////
  deleteTabCommonQuery(String table) async {
    Database db = await instance.database;
    await db.delete('$table');
  }
//////////////////////////////
  ////////////count from table/////////////////////////////////////////
  countCommonQuery(String table, String os, String customerId) async {
    String count;
    Database db = await instance.database;

    final result = await db.rawQuery(
        'SELECT COUNT(*) c FROM $table WHERE os="$os" AND customerid="$customerId"');
    count = result[0]["c"].toString();
    print("result---count---$result");
    return count;
  }

//////////////////////////////////////////////////////////////////
  getMaxCommonQuery(String table, String field, String condition) async {
    var res;
    int max;
    Database db = await instance.database;
    print("field----condition---table ----${field}---${condition}----${table}");
    var result = await db.rawQuery("SELECT * FROM '$table' WHERE $condition");
    print("result max---$result");
    if (result != null && result.isNotEmpty) {
      print("if");
      res = await db.rawQuery(
          "SELECT MAX($field) max_val FROM '$table' WHERE $condition");
      print("max common-----$res");   
      print('res[0]["max_val"] ----${res[0]["max_val"]}');
      // int convertedMax = int.parse(res[0]["max_val"]);
      max = res[0]["max_val"] + 1;
      print("SELECT MAX($field) max_val FROM '$table' WHERE $condition");
    } else {
      print("else");
      max = 1;
    }
    print(res);
    return max;
  }
}
