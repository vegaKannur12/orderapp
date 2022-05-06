import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/registration_model.dart';
import 'package:orderapp/screen/companyDetailsscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  String? cid;
  List<CD> c_d = [];
  List<CD> data = [];
  String? sof;
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
      //       snme: item.snme,
      //       unme: item.unme,
      //       pwd: item.hoid,
      //       ad1: item.ad1,
      //       ad2: item.ad2,
      //       ad3: item.ad3,
      //       ph: item.ph,
      //      );
      //   var res = await OrderAppDB.instance.insertRegistrationDetails(dataDetails);
      // }
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
