import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/model.dart';

class Controller extends ChangeNotifier {
  
  Future<RegistrationData?> postRegistration(String company_code) async {
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
      Map body = {
        'company_code': company_code,
      };
      print("compny----${company_code}");
      http.Response response = await http.post(
        url,
        body: body,
        //   headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        // }
      );
      print("body ${body}");
      var map = jsonDecode(response.body);
      print("map ${map}");
      RegistrationData regModel = RegistrationData.fromJson(map);
      // late Data dataDetails;
      // for (var item in RegistrationData.data!) {
      //   dataDetails = Data(
      //       cid: item.cid,
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
      return regModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

    Future<RegistrationData?> postStaffDetails(String company_code) async {
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_staff.php");
      Map body = {
        'company_code': "RONPBQ9AD5D",
      };
      print("compny----${company_code}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      var map = jsonDecode(response.body);
      print("map ${map}");
      RegistrationData regModel = RegistrationData.fromJson(map);

      /////////////// insert into local db /////////////////////
      // late Data dataDetails;
      // for (var item in RegistrationData.data!) {
      //   dataDetails = Data(
      //       cid: item.cid,
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
      return regModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
