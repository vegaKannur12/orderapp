import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/accounthead_model.dart';
import 'package:orderapp/model/productCompany_model.dart';
import 'package:orderapp/model/productsCategory_model.dart';
import 'package:orderapp/model/registration_model.dart';
import 'package:orderapp/screen/companyDetailsscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/network_connectivity.dart';
import '../model/productdetails_model.dart';
import '../model/staffarea_model.dart';
import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  bool isListLoading = false;

  bool isSearch = false;
  bool isVisible = false;
  List<bool> selected = [];
  String? searchkey;
  String? sname;
  String? orderTotal;
  String? ordernumber;
  String? cid;
  String? cname;
  int? qtyinc;
  List<CD> c_d = [];
  String? area;
  String? splittedCode;
  double amt = 0.0;
  List<CD> data = [];
  double? totalPrice;
  List<String> areaAutoComplete = [];

  List<Map<String, dynamic>> listWidget = [];
  List<TextEditingController> controller = [];
  List<TextEditingController> qty = [];

  String count = "0";
  String? sof;
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> newList = [];
  List<Map<String, dynamic>> masterList = [];
  List<Map<String, dynamic>> orderdetailsList = [];

  List<Map<String, dynamic>> staffList = [];
  List<Map<String, dynamic>> productName = [];
  List<Map<String, dynamic>> areDetails = [];
  List<Map<String, dynamic>> custmerDetails = [];
  List<Map<String, dynamic>> areaList = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> copyCus = [];
  List<Map<String, dynamic>> prodctItems = [];
  List<Map<String, dynamic>> ordernum = [];
  List<Map<String, dynamic>> approximateSum = [];
  StaffDetails staffModel = StaffDetails();
  AccountHead accountHead = AccountHead();
  StaffArea staffArea = StaffArea();
  ProductDetails proDetails = ProductDetails();
////////////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
          };
          print("compny----${company_code}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );

          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map ${map}");
          // print("response ${response}");
          RegistrationData regModel = RegistrationData.fromJson(map);
          sof = regModel.sof;
          print("sof----${sof}");
          if (sof == "0") {
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(context, "Invalid Company Key");
          }

          if (sof == "1") {
            /////////////// insert into local db /////////////////////
            late CD dataDetails;
            String? fp = regModel.fp;
            String? os = regModel.os;
            regModel.c_d![0].cid;
            cid = regModel.cid;
            cname = regModel.c_d![0].cnme;
            notifyListeners();
            for (var item in regModel.c_d!) {
              c_d.add(item);
            }
            var res =
                await OrderAppDB.instance.insertRegistrationDetails(regModel);

            print("inserted ${res}");
            isLoading = false;
            notifyListeners();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("company_id", company_code);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompanyDetails()),
            );
          }
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////// Staff details////////////////////////////////

  Future<StaffDetails?> getStaffDetails(String cid) async {
    // print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_staff.php");
      Map body = {
        'cid': cid,
      };
      // print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      // print("body ${body}");
      List map = jsonDecode(response.body);

      for (var staff in map) {
        // print("staff----${staff}");
        staffModel = StaffDetails.fromJson(staff);
        var restaff = await OrderAppDB.instance.insertStaffDetails(staffModel);
        // print("inserted ${restaff}");
      }
      /////////////// insert into local db /////////////////////
      notifyListeners();
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

////////////////////// Staff Area ///////////////////////////////////
  Future<StaffArea?> getAreaDetails(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_area.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      for (var staffarea in map) {
        print("staffarea----${staffarea}");
        staffArea = StaffArea.fromJson(staffarea);
        var staffar =
            await OrderAppDB.instance.insertStaffAreaDetails(staffArea);
        print("inserted ${staffar}");
      }
      /////////////// insert into local db /////////////////////
      notifyListeners();
      return staffArea;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////// account head ///////////////////////////////////////
  Future<AccountHead?> getaccountHeadsDetails(String cid, String? load) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_achead.php");
      Map body = {
        'cid': cid,
      };
      if (load != "all") {
        isLoading = true;
        notifyListeners();
      }

      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("accountHeadsTable", "");
      for (var ahead in map) {
        print("ahead------${ahead}");
        accountHead = AccountHead.fromJson(ahead);
        var account = await OrderAppDB.instance.insertAccoundHeads(accountHead);
      }

      if (load != "all") {
        isLoading = false;
        notifyListeners();
      }
      // return accountHead;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///////////////////////////////////////////////////////////
  setCname() async {
    final prefs = await SharedPreferences.getInstance();
    String? came = prefs.getString("cname");
    cname = came;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////
  setSname() async {
    final prefs = await SharedPreferences.getInstance();
    String? same = prefs.getString("st_username");
    sname = same;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////
  Future<ProductDetails?> getProductDetails(String cid, String? load) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_prod.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      if (load != "all") {
        isLoading = true;
        notifyListeners();
      }
      http.Response response = await http.post(
        url,
        body: body,
      );
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("productDetailsTable", "");
      // print("body ${body}");
      List map = jsonDecode(response.body);
      // print("map ${map}");
      for (var pro in map) {
        proDetails = ProductDetails.fromJson(pro);
        var product =
            await OrderAppDB.instance.insertProductDetails(proDetails);
      }
      if (load != "all") {
        isLoading = false;
        notifyListeners();
      }
      /////////////// insert into local db /////////////////////

    } catch (e) {
      print(e);
      return null;
    }
  }

  /////////////////////////////product category//////////////////////////////
  Future<ProductsCategoryModel?> getProductCategory(
      String cid, String? load) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_cat.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      if (load != "all") {
        isLoading = true;
        notifyListeners();
      }
      http.Response response = await http.post(
        url,
        body: body,
      );
      // print("body ${body}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("productsCategory", "");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductsCategoryModel category;
      ;
      for (var cat in map) {
        category = ProductsCategoryModel.fromJson(cat);
        var product = await OrderAppDB.instance.insertProductCategory(category);
        if (load != "all") {
          isLoading = false;
          notifyListeners();
        }
        // print("inserted ${account}");
      }
      /////////////// insert into local db /////////////////////
      // notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////get company//////////////////////////////////
  Future<ProductCompanymodel?> getProductCompany(
      String cid, String? load) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_com.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");

      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      await OrderAppDB.instance.deleteFromTableCommonQuery("companyTable", "");
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductCompanymodel productCompany;
      for (var proComp in map) {
        productCompany = ProductCompanymodel.fromJson(proComp);
        var product =
            await OrderAppDB.instance.insertProductCompany(productCompany);
        if (load != "all") {
          isLoading = false;
          notifyListeners();
          // notifyListeners();
        }
        // print("inserted ${account}");
      }
      /////////////// insert into local db /////////////////////

    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////////////////////////////////////////
  getArea(String staffName) async {
    print("staff...............${staffName}");
    try {
      areaList = await OrderAppDB.instance.getArea(staffName);
      print("areaList----${areaList}");
      for (var item in areaList) {
        areDetails.add(item);
      }
      print("areaList adding ----${areaList}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  /////////////////////////////////////////////////////
  getCustomer(String aid) async {
    print("aid...............${aid}");
    try {
      print("custmerDetails after clear----${custmerDetails}");
      custmerDetails.clear();
      customerList = await OrderAppDB.instance.getCustomer(aid);
      print("customerList----${customerList}");
      for (var item in customerList) {
        custmerDetails.add(item);
      }
      print("custmerDetails adding $custmerDetails");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  /////////////////////////////////////////////////////
  customerListClear() {
    customerList.clear();
    notifyListeners();
  }

  setSplittedCode(String splitted) {
    splittedCode = splitted;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  getProductList(String customerId) async {
    print("haii---");
    int flag = 0;
    productName.clear();
    try {
      isLoading = true;
      // notifyListeners();
      prodctItems =
          await OrderAppDB.instance.selectfromOrderbagTable(customerId);
      print("prodctItems----${prodctItems.length}");

      for (var item in prodctItems) {
        productName.add(item);
      }
      var length = productName.length;
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);
      isLoading = false;
      notifyListeners();
      print("product name----${productName}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  selectedSet(){
    var length = productName.length;
      qty = List.generate(length, (index) => TextEditingController());

      selected = List.generate(length, (index) => false);

  }

/////////////////////////////////////////////////////////////
  // getProductItems(String table) async {
  //   productName.clear();
  //   try {
  //     isLoading = true;
  //     // notifyListeners();
  //     prodctItems = await OrderAppDB.instance.selectCommonquery(table, '');
  //     print("prodctItems----${prodctItems}");

  //     for (var item in prodctItems) {
  //       productName.add(item);
  //       // productName.add(item["code"] + '-' + item["item"]);
  //       // notifyListeners();
  //     }
  //     var length = productName.length;
  //     print("text length----$length");
  //     qty = List.generate(length, (index) => TextEditingController());
  //     isLoading = false;
  //     notifyListeners();
  //     print("product name----${productName}");
  //     // print("product productRate----${productRate}");
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  //   notifyListeners();
  // }

////////////////////////////////////////////////////////////
  getOrderno() async {
    try {
      ordernum = await OrderAppDB.instance.getOrderNo();
      print("ordernum----${ordernum}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  /////////////////////////////////////

////////////////////////////////
  generateTextEditingController() {
    var length = bagList.length;
    print("text length----$length");
    controller = List.generate(length, (index) => TextEditingController());
    print("length----$length");
    // notifyListeners();
  }

  /////////////////////////////////
  calculateAmt(String rate, String _controller) {
    amt = double.parse(rate) * double.parse(_controller);
    // notifyListeners();
  }

  ////////////////////////////////////
  getBagDetails(String customerId, String os) async {
    bagList.clear();
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.getOrderBagTable(customerId, os);
    for (var item in res) {
      bagList.add(item);
    }
    generateTextEditingController();
    print("bagList vxdvxd----$bagList");

    isLoading = false;
    notifyListeners();
  }

  ///////////////////////////////////
  deleteFromOrderBagTable(int cartrowno, String customerId, int index) async {
    print("cartrowno--$cartrowno--index----$index");
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .deleteFromOrderbagTable(cartrowno, customerId);

    bagList.clear();
    for (var item in res) {
      bagList.add(item);
    }
    print("after delete------$res");
    controller.removeAt(index);
    print("controllers----$controller");
    generateTextEditingController();
    notifyListeners();
  }

  /////////////////////////////updateqty/////////////////////
  updateQty(String qty, int cartrowno, String customerId, String rate) async {
    // print("qty-----${qty}");
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .updateQtyOrderBagTable(qty, cartrowno, customerId, rate);

    if (res.length >= 0) {
      bagList.clear();
      for (var item in res) {
        bagList.add(item);
      }
      print("re from controller----$res");
      notifyListeners();
    }
  }

////////////// total sum /////////////////////////////
  // gettotalSum() async {
  //   try {
  //     approximateSum = await OrderAppDB.instance.gettotalSum();

  //     print("total----${approximateSum}");

  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  //   notifyListeners();
  // }

  /////////calculate total////////////////
  calculateTotal(String os, String customerId) async {
    orderTotal = await OrderAppDB.instance.gettotalSum(os, customerId);
    print("orderTotal---$orderTotal");
    notifyListeners();
  }

  ////////////////count from table///////
  countFromTable(String table, String os, String customerId) async {
    isLoading = true;
    // notifyListeners();
    print("table--customerId-$table-$customerId");
    count = await OrderAppDB.instance
        .countCommonQuery(table, "os='${os}' AND customerid='${customerId}'");
    isLoading = false;

    notifyListeners();
  }

  //////////////insert to order master and details///////////////////////

  insertToOrderbagAndMaster(String os, String date, String customer_id,
      String user_id, String aid) async {
    int order_id = await OrderAppDB.instance
        .getMaxCommonQuery('orderDetailTable', 'order_id', "os='${os}'");
    int rowNum = 1;
    if (bagList.length > 0) {
      await OrderAppDB.instance.insertorderMasterandDetailsTable(
          order_id,
          0,
          " ",
          " ",
          date,
          os,
          customer_id,
          user_id,
          aid,
          1,
          rowNum,
          "orderMasterTable");

      for (var item in bagList) {
        print("orderid---$order_id");
        await OrderAppDB.instance.insertorderMasterandDetailsTable(
            order_id,
            item["qty"],
            item["rate"],
            item["code"],
            date,
            os,
            customer_id,
            user_id,
            aid,
            1,
            rowNum,
            "orderDetailTable");
        rowNum = rowNum + 1;
      }
    }
    await OrderAppDB.instance.deleteFromTableCommonQuery(
        "orderBagTable", "os='${os}' AND customerid='${customer_id}'");
    bagList.clear();
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////////
  searchProcess(String customerId, String os) async {
    print("searchkey----$searchkey");

    newList.clear();

    if (searchkey!.isEmpty) {
      newList = productName;
      var length = newList.length;
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);
    } else 
    {
      // newList.clear();
      isListLoading = true;
      notifyListeners();
      print("else is search");
      isSearch = true;

      // newList = productName
      //     .where((product) =>
      //         product["item"]
      //             .toLowerCase()
      //             .contains(searchkey!.toLowerCase()) ||
      //         product["code"]
      //             .toLowerCase()
      //             .contains(searchkey!.toLowerCase()) ||
      //         product["categoryId"]
      //             .toLowerCase()
      //             .contains(searchkey!.toLowerCase()))
      //     .toList();

      // List<Map<String, dynamic>> res =
      //     await OrderAppDB.instance.getOrderBagTable(customerId, os);
      // for (var item in res) {
      //   bagList.add(item);
      // }
// print("jhfdjkhfjd----$bagList");
      List<Map<String, dynamic>> result = await OrderAppDB.instance.searchItem(
          'productDetailsTable', searchkey!, 'item', 'code', 'categoryId');
      for (var item in result) {
        newList.add(item);
      }
        isListLoading=false;
    notifyListeners();
      var length = newList.length;
      selected = List.generate(length, (index) => false);
      qty = List.generate(length, (index) => TextEditingController());

      if (newList.length > 0) {
        print("enterde");
        for (var item = 0; item < newList.length; item++) {
          print("newList[item]----${newList[item]}");

          for (var i = 0; i < bagList.length; i++) {
            print("bagList[item]----${bagList[i]}");

            if (bagList[i]["code"] == newList[item]["code"]) {
              print("ifff");
              selected[item] = true;
              break;
            } else {
              print("else----");
              selected[item] = false;
            }
          }
        }
      }

      print("text length----$length");

      print("selected[item]-----${selected}");

      // notifyListeners();
    }

    print("nw list---$newList");
    notifyListeners();
  }

  //////////////////staff log details insertion//////////////////////
  insertStaffLogDetails(String sid, String sname, String datetime) async {
    var logdata =
        await OrderAppDB.instance.insertStaffLoignDetails(sid, sname, datetime);
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////
  downloadAllPages(String cid) async {
    isLoading = true;
    print("isloaading---$isLoading");
    notifyListeners();
    // getaccountHeadsDetails(cid, "all");
    getProductCategory(cid, "all");
    getProductCompany(cid, "all");
    // getProductDetails(cid, "all");
    isLoading = false;
    print("isloaading---$isLoading");

    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////
  qtyIncrement() {
    qtyinc = 1 + qtyinc!;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////
  qtyDecrement() {
    qtyinc = qtyinc! - 1;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  /////////////////////////////////////////////////
  setIssearch(bool issearch) {
    isSearch = issearch;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////
  setQty(int qty) {
    qtyinc = qty;
    // notifyListeners();
  }

  ///////////////////////
  ///
  setAmt(
    String price,
  ) {
    totalPrice = double.parse(price);

    // notifyListeners();
  }

  totalCalculation(String rate) {
    totalPrice = double.parse(rate) * qtyinc!;
    print("total pri-----$totalPrice");
    notifyListeners();
  }

  setisVisible(bool isvis) {
    isVisible = isvis;
    notifyListeners();
  }
}
