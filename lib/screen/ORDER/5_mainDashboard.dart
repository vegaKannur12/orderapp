import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/areaPopup.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ORDER/homePage.dart';
import 'package:orderapp/screen/ORDER/todaycollectionPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum WidgetMarker {
  home,
  order,
  collection,
  report,
}

class MainDashboard extends StatefulWidget {
  String type;
  MainDashboard({required this.type});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String? cuid;
  HomeWidget homepage = HomeWidget();
  TodayCollectionPage collectionPage = TodayCollectionPage();
  WidgetMarker selectedWidgetMarker = WidgetMarker.home;
  DateTime date = DateTime.now();
  String? formattedDate;
  String? selected;
  AreaSelectionPopup popup = AreaSelectionPopup();
  String? sid;
  final _random = Random();
  sharedPref() async {
    print("helooo");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
    await Provider.of<Controller>(context, listen: false)
        .selectTotalPrice(sid!, formattedDate!);
    Provider.of<Controller>(context, listen: false)
        .selectOrderCount(sid!, formattedDate!);
    await Provider.of<Controller>(context, listen: false)
        .selectCollectionPrice(sid!, formattedDate!);
    await Provider.of<Controller>(context, listen: false)
        .CollectionCount(sid!, formattedDate!);
    await Provider.of<Controller>(context, listen: false)
        .fetchrcollectionFromTable(sid!, formattedDate!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    Provider.of<Controller>(context, listen: false).setFilter(false);
    Provider.of<Controller>(context, listen: false)
        .selectReportFromOrder(context);
    sharedPref();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget home() {
      return homepage.home(context);
    }

    Widget order() {
      return Container(
        child: Text("Order"),
      );
    }

    Widget collection() {
      return collectionPage.collectionPage(context);
    }

    Widget getCustomContainer() {
      print("inside switch case");
      switch (selectedWidgetMarker) {
        // case widget.type:
        //    return home();
        case WidgetMarker.home:
          return home();
          break;
        case WidgetMarker.order:
          return order();
          break;
        case WidgetMarker.collection:
          return collection();
          break;
        default:
          return home();
          break;
      }
    }

    return Column(
      children: [
        Consumer<Controller>(
          builder: (context, value, child) {
            return Expanded(
              child: Container(
                height: size.height * 0.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(95),
                        // topRight: Radius.circular(95),
                        ),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: size.height * 0.05,
                          color: P_Settings.wavecolor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTapCancel: () {
                                      selectedWidgetMarker = WidgetMarker.home;
                                    },
                                    onTap: () {
                                      setState(() {
                                        selectedWidgetMarker =
                                            WidgetMarker.home;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: P_Settings.collection3,
                                        ),
                                      ),
                                      height: size.height * 0.03,
                                      width: size.width * 0.15,
                                      child: Text(
                                        "Home",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: P_Settings.collection),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedWidgetMarker =
                                            WidgetMarker.order;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color.fromARGB(
                                              255, 218, 210, 210),
                                        ),
                                        // borderRadius: BorderRadius.all(
                                        //   Radius.circular(10),
                                        // ),
                                      ),
                                      // color: P_Settings.collection1,

                                      width: size.width * 0.35,
                                      height: size.height * 0.03,
                                      child: Text(
                                        "Todays Order",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: P_Settings.collection),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedWidgetMarker =
                                            WidgetMarker.collection;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: P_Settings.collection,
                                        ),
                                        // borderRadius: BorderRadius.all(
                                        //   Radius.circular(10),
                                        // ),
                                      ),
                                      // color: P_Settings.collection1,
                                      height: size.height * 0.03,
                                      width: size.width * 0.4,
                                      child: Text(
                                        "Todays Collection",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: P_Settings.collection),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // selectedWidgetMarker = WidgetMarker.date;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: P_Settings.collection,
                                        ),
                                      ),
                                      height: size.height * 0.03,
                                      width: size.width * 0.25,
                                      child: Text(
                                        "Todays Sale",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: P_Settings.collection),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // selectedWidgetMarker = WidgetMarker.date;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: P_Settings.collection,
                                        ),
                                      ),
                                      height: size.height * 0.03,
                                      width: size.width * 0.25,
                                      child: Text(
                                        "Report",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: P_Settings.collection),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.1,
                        width: double.infinity,
                        // color: P_Settings.collection,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                    radius: 15,
                                    child: Icon(
                                      Icons.person,
                                      color: P_Settings.collection1,
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 214, 201, 200),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Text("${value.cname}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: P_Settings.wavecolor)),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Text("- ${value.sname}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: P_Settings.collection1))
                              ],
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 7,
                        width: double.infinity,
                        child: GestureDetector(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  getCustomContainer();
                                  print("helooooooooooo");
                                });
                              }
                            },
                            child: getCustomContainer()),
                      ),
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
