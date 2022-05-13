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

import '../model/productdetails_model.dart';
import '../model/staffarea_model.dart';
import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  String? sname;
  String? ordernumber;
  String? cid;
  String? cname;
  List<CD> c_d = [];
  String? area;
  String? splittedCode;
  String? splittedCode1;

  List<CD> data = [];
  String? sof;
  List<Map<String, dynamic>> staffList = [];
  List<String> productName = [];
  List<String> productRate = [];

  List<Map<String, dynamic>> areaList = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> copyCus = [];
  List<Map<String, dynamic>> prodctItems = [];
  List<Map<String, dynamic>> ordernum = [];

  StaffDetails staffModel = StaffDetails();
  AccountHead accountHead = AccountHead();
  StaffArea staffArea = StaffArea();
  ProductDetails proDetails = ProductDetails();
////////////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code, BuildContext context) async {
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
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
        var res = await OrderAppDB.instance.insertRegistrationDetails(regModel);
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
  Future<AccountHead?> getaccountHeadsDetails(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_achead.php");
      Map body = {
        'cid': cid,
      };
      isLoading = true;
      notifyListeners();
      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      for (var ahead in map) {
        print("ahead------${ahead}");
        accountHead = AccountHead.fromJson(ahead);
        var account = await OrderAppDB.instance.insertAccoundHeads(accountHead);

        // print("inserted ${account}");
      }
      isLoading = false;

      /////////////// insert into local db /////////////////////
      notifyListeners();
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
  Future<ProductDetails?> getProductDetails(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_prod.php");
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
      // print("body ${body}");
      List map = jsonDecode(response.body);
      // print("map ${map}");
      for (var pro in map) {
        proDetails = ProductDetails.fromJson(pro);
        var product =
            await OrderAppDB.instance.insertProductDetails(proDetails);
        // print("inserted ${account}");
      }
      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
      notifyListeners();
      return proDetails;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /////////////////////////////product category//////////////////////////////
  Future<ProductsCategoryModel?> getProductCategory(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_cat.php");
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
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductsCategoryModel category;
      ;
      for (var cat in map) {
        category = ProductsCategoryModel.fromJson(cat);
        var product = await OrderAppDB.instance.insertProductCategory(category);
        isLoading = false;
        notifyListeners();
        // print("inserted ${account}");
      }
      /////////////// insert into local db /////////////////////
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////get company//////////////////////////////////
  Future<ProductCompanymodel?> getProductCompany(String cid) async {
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
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductCompanymodel productCompany;
      for (var proComp in map) {
        productCompany = ProductCompanymodel.fromJson(proComp);
        var product =
            await OrderAppDB.instance.insertProductCompany(productCompany);
        isLoading = false;
        notifyListeners();
        // print("inserted ${account}");
      }
      /////////////// insert into local db /////////////////////
      notifyListeners();
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
      copyCus.clear();
      customerList.clear();

      print("aid---...............${aid}");

      customerList = await OrderAppDB.instance.getCustomer(aid);
      // for (var item in customerList){
      //   copyCus.add(item);
      // }
      print("customerList----${customerList}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  getProductItems(String product) async {
    print("product...............${product}");
    try {
      prodctItems = await OrderAppDB.instance.getItems(product);
      print("prodctItems----${prodctItems}");

      for (var item in prodctItems) {
        productName.add(item["code"] + '-' + item["item"]);
        // productRate.add(item['rate1']); 
      }
      print("product name----${productName}");
      print("product productRate----${productRate}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

////////////////////////////////////////
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
}
