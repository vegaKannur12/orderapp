import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/model/model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
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
}
