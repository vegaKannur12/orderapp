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
    Provider.of<Controller>(context, listen: false).selectTotalPrice(sid!);
    Provider.of<Controller>(context, listen: false)
        .selectCollectionPrice(sid!, formattedDate!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    //  _controller = TabController(vsync: this, length: 3);
    sharedPref();
  }

  @override
  void dispose() {
    // _controller.dispose();
    // TODO: implement dispose
    super.dispose();
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
          height: size.height * 0.15,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Consumer<Controller>(
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
                          // Container(
                          //   decoration: new BoxDecoration(
                          //       color: Theme.of(context).primaryColor),
                          //   child:
                          // ),
                        ],
                      );
                    },
                  ),
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
                        // topLeft: Radius.circular(95),
                        // topRight: Radius.circular(95),
                        ),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Todays",
                          style: TextStyle(
                              fontSize: 20,
                              color: P_Settings.wavecolor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: size.height * 0.9,
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: P_Settings.dashbordcl1,
                                          ),
                                          height: size.height * 0.1,
                                          width: size.height * 0.6,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Collection",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Text(
                                                  "\u{20B9}${value.collectionsumPrice.length != 0 && value.collectionsumPrice[0]['S'] != null && value.collectionsumPrice.isNotEmpty ? value.collectionsumPrice[0]['S'] : "0"}",
                                                  style: TextStyle(
                                                      color:
                                                          P_Settings.extracolor,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: P_Settings.dashbordcl3,
                                          ),
                                          height: size.height * 0.1,
                                          width: size.height * 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Orders",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Text(
                                                  "\u{20B9}${value.sumPrice.length != 0 && value.sumPrice[0]['s'] != null && value.sumPrice.isNotEmpty ? value.sumPrice[0]['s'] : "0"}",
                                                  style: TextStyle(
                                                      color:
                                                          P_Settings.extracolor,
                                                      fontSize: 18),
                                                ),
                                                // Text(
                                                //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                //   style: TextStyle(fontSize: 15),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl2,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Sales",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl1,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .extracolor,
                                                        fontSize: 18),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: size.height * 0.01,
                                // ),
                                Flexible(
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl3,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Sales",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl2,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .extracolor,
                                                        fontSize: 18),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      alignment: Alignment.center,
                                      height: size.height * 0.05,
                                      width: double.infinity,
                                      child: Text(
                                        "Today Collection",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: P_Settings.wavecolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl1,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Collection",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "\u{20B9}${value.collectionsumPrice.length != 0 && value.collectionsumPrice[0]['S'] != null && value.collectionsumPrice.isNotEmpty ? value.collectionsumPrice[0]['S'] : "0"}",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .extracolor,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl3,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Orders",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "\u{20B9}${value.sumPrice.length != 0 && value.sumPrice[0]['s'] != null && value.sumPrice.isNotEmpty ? value.sumPrice[0]['s'] : "0"}",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .extracolor,
                                                        fontSize: 18),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: P_Settings.dashbordcl2,
                                              ),
                                              height: size.height * 0.1,
                                              width: size.height * 0.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Sales",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl1,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .extracolor,
                                                        fontSize: 18),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: P_Settings.dashbordcl3,
                                              ),
                                              height: size.height * 0.1,
                                              width: size.height * 0.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Sales",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl2,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .extracolor,
                                                        fontSize: 18),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ],
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
