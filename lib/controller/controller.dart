import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/model/registration_model.dart';

import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  String? cid;
  List<CD> c_d = [];
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
      cid=regModel.cid;
      for (var item in regModel.c_d!) {
        c_d.add(item);
      }
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////////
  ///
  Future<StaffDetails?> getStaffDetails(String cid) async {
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_staff.php");
      Map body = {
        'cid': "CO1001",
      };
      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      var map = jsonDecode(response.body);
      print("map ${map}");
      StaffDetails staffModel = StaffDetails.fromJson(map);

      /////////////// insert into local db /////////////////////
      late StaffDetails dataDetails;
      // for (var item in StaffDetails.data!) {
      //   dataDetails = Data(
      //       sid: item.sid,
      //       cpre: item.cpre,
      //       ctype: item.ctype,
      //       hoid: item.hoid,
      //       cnme: item.cnme,
      //       ad1: item.ad1,
      //       ad2: item.ad2,
      //       ad3: item.ad3,
      //       ad1: item.ad1,
      //       ad1: item.ad1,
      //       ad1: item.ad1,
      //       gst: item.gst,
      //       ccode: item.ccode,
      //       scode: item.scode);
      //   var res = await OrderAppDB.instance.insertRegistrationDetails(dataDetails);
      // }
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
