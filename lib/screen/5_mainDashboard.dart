import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  DateTime date = DateTime.now();
  String? formattedDate;
  List companyAttributes = [
    "Collection",
    "Orders",
    "Sale",
  ];
  String? sid;
  final _random = Random();
  sharedPref() async {
    print("helooo");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
    Provider.of<Controller>(context, listen: false).selectTotalPrice(
      sid!,formattedDate!
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    sharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(50),
                // bottomRight: Radius.circular(50),
                ),
            // color: P_Settings.roundedButtonColor
          ),
          alignment: Alignment.center,
          height: size.height * 0.09,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("${cname}",
                //     style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         color: P_Settings.headingColor)),
                // SizedBox(
                //   height: 15,
                // ),
                // Text("${sname}",
                //     style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.bold,
                //         color: P_Settings.extracolor)),
                Consumer<Controller>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        Text("${value.cname}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: P_Settings.detailscolor)),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text("${value.sname}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: P_Settings.extracolor)),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Consumer<Controller>(
          builder: (context, value, child) {
            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(95),
                      topRight: Radius.circular(95),
                    ),
                    color: Colors.white),
                // color: P_Settings.wavecolor,
                // height: size.height*0.6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: GridView.builder(
                    itemCount: companyAttributes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(15.0),
                          // ),
                          elevation: 0,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment(0.8,
                              //       0.3), // 10% of the width, so there are ten blinds.
                              //   colors: <Color>[
                              //     Color.fromARGB(255, 162, 72, 214),
                              //     Color.fromARGB(255, 88, 86, 202)
                              //   ], // red to yellow
                              //   // repeats the gradient over the canvas
                              // ),
                              color: Color.fromRGBO(
                                  _random.nextInt(212),
                                  _random.nextInt(212),
                                  _random.nextInt(212),
                                  _random.nextDouble()),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35),
                              ),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            height: 40,
                            width: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  companyAttributes[index],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // companyAttributes[index] == "Orders"
                                //     ? Text(
                                //         "\u{20B9}${value.sumPrice[0]['S']}",
                                //         style: TextStyle(
                                //             fontSize: 20, color: Colors.pink),
                                //       )
                                //     : Text(""),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
