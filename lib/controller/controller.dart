import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/accounthead_model.dart';
import 'package:orderapp/model/registration_model.dart';
import 'package:orderapp/screen/companyDetailsscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/staffarea_model.dart';
import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  String sname="";
  String? cid;
  List<CD> c_d = [];
  List<CD> data = [];
  String? sof;
  List<Map<String, dynamic>> staffList = [];
  StaffDetails staffModel = StaffDetails();
  AccountHead accountHead = AccountHead();
  StaffArea staffArea = StaffArea();
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
      // print("map ${map}");
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
        staffArea= StaffArea.fromJson(staffarea);
        var staffar = await OrderAppDB.instance.insertStaffAreaDetails(staffArea);
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
        accountHead= AccountHead.fromJson(ahead);
        var account = await OrderAppDB.instance.insertAccoundHeads(accountHead);
        // print("inserted ${account}");
      }
      /////////////// insert into local db /////////////////////
      notifyListeners();
      return accountHead;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
