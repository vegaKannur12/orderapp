import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/model.dart';

class Controller extends ChangeNotifier {
  List registerlist = [];
  String idname = "RONPBQ9AD5D";
  var id = 1;
  Future<RegistrationData?> postRegistration(String company_code, String device_id,String app_id) async {
    try {
      Uri url = Uri.parse("http://trafiqerp.in/ydx/send_regkey");
      Map<String, dynamic> body = {
        'company_code': company_code,
        'device_id': device_id,
        'app_id': app_id,
      };
      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = jsonDecode(response.body);
      print("from post data ${map}");
      print('user id------------${map["UserId"]}');
      // RegistrationModel regModel=RegistrationModel.fromJson(map);
      int uid=int.parse(map["UserId"].toString());
      // var result=await BarcodeScanlogDB.instance.insertRegistrationDetails(company_code, device_id, "free to scan",map["CompanyId"], map["CompanyName"], map["UserId"], map["ExpiryDate"]);
      // return regModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
  }
  // late Map<String, dynamic> registrationList ;
  // String idname = "RONPBQ9AD5D";
  // var id = 1;
  // Future<registrationData?> getRegistrationDetails() async {
  //   print("helooooooooo");
  //   try {
  //     Uri url = Uri.parse(
  //         "http://trafiqerp.in/order/fj/get_registration.php?json_result=[{$id:$idname}]");
  //         print(url);
  //     http.Response response = await http.post(
  //       url,
  //       // body: body,
  //     );
  //     registrationList.clear();
  //     var map = jsonDecode(response.body);
  //     print(map);

  //     // for (var item in map) {
  //     //   registrationList.add(item);
  // //     // }
  //     notifyListeners();
  //     return map;

  // print("report details ${registrationList}");
  //
  // } catch (e) {
  //   print(e);
  //   return null;
  // }
//   }

