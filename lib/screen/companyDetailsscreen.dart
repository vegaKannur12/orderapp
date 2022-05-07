import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customAppbar.dart';
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/staffLoginScreen.dart';
import 'package:provider/provider.dart';

class CompanyDetails extends StatefulWidget {
  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  CustomSnackbar _snackbar = CustomSnackbar();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: P_Settings.detailscolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Company Details",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   "Company Details",
                  //   style:
                  //       TextStyle(fontSize: 20, color: P_Settings.headingColor),
                  // ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer<Controller>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Container(
                          height: size.height * 0.9,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        if (value.c_d != null && value.c_d.length > 0) {
                          return FittedBox(
                            child: Container(
                              height: size.height * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.04,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                          "company name : ${(value.c_d[0].cnme == null) && (value.c_d[0].cnme!.isEmpty) ? "" : value.c_d[0].cnme}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.book),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "Address1           : ${value.c_d[0].ad1}",
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.book),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "Address2            : ${value.c_d[0].ad2}",
                                        // value.reportList![index]['filter_names'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.pin),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "PinCode              : ",
                                        // value.reportList![index]['filter_names'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.business),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "CompanyPrefix  : ${value.c_d[0].cpre}",
                                        // value.reportList![index]['filter_names'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.landscape),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "Land                    : ${value.c_d[0].land}",
                                        // value.reportList![index]['filter_names'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "Mobile                 : ${value.c_d[0].mob}",
                                        // value.reportList![index]['filter_names'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.design_services),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "GST                      : ${value.c_d[0].gst}",
                                        // value.reportList![index]['filter_names'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.copy_rounded),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "Country Code     : ${value.c_d[0].ccode}",
                                        // value.reportList![index]['filter_names'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.04,
                                  ),
                                  Text(
                                    "Company Registration Successfull",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      String cid = Provider.of<Controller>(
                                              context,
                                              listen: false)
                                          .cid!;
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getStaffDetails(cid);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getAreaDetails(cid);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StaffLogin()),
                                      );
                                      // _snackbar.showSnackbar(context,"Staff Details Saved");
                                    },
                                    child: Text("Continue"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            child: Text(""),
                          );
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
