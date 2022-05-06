import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/registration_model.dart';

import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  String? cid;
  List<CD> c_d = [];
  List<CD> data = [];
  StaffDetails staffModel = StaffDetails();
////////////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(String company_code) async {
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
      isLoading = false;
      notifyListeners();
      print("body ${body}");
      var map = jsonDecode(response.body);
      print("map ${map}");
      print("response ${response}");
      RegistrationData regModel = RegistrationData.fromJson(map);
      print("gre model===${regModel.c_d![0]}");
      cid = regModel.cid;
      for (var item in regModel.c_d!) {
        c_d.add(item);
      }

      /////////////// insert into local db /////////////////////
      var res = await OrderAppDB.instance.insertRegistrationDetails(regModel);
      print("inserted ${res}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////////
  ///
  Future<StaffDetails?> getStaffDetails(String cid) async {
    
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_staff.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      var map = jsonDecode(response.body);
      print("map ${map}");
      staffModel = StaffDetails.fromJson(map[0]);
      /////////////// insert into local db /////////////////////
      var restaff = await OrderAppDB.instance.insertStaffDetails(staffModel);
      print("inserted ${restaff}");
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
