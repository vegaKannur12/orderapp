import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/6_downloadedPage.dart';
import 'package:orderapp/screen/6_historypage.dart';
import 'package:orderapp/screen/5_mainDashboard.dart';
import 'package:orderapp/screen/3_staffLoginScreen.dart';
import 'package:orderapp/screen/6_uploaddata.dart';
import 'package:orderapp/service/tableList.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';
import '6_orderForm.dart';

class Dashboard extends StatefulWidget {
  String? type;

  String? areaName;
  Dashboard({this.type, this.areaName});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // int _selectedDrawerIndex = 0;

  ValueNotifier<bool> upselected = ValueNotifier(false);
  ValueNotifier<bool> dwnselected = ValueNotifier(false);

  String? cid;
  String menu_index = "S1";
  List defaultitems = ["upload data", "download page", "logout"];
  List companyAttributes = [
    "Dashboard",
    "Logged in",
    "Collection",
    "Orders",
    "Sale",
    "Download Page",
    "Upload data",
    "history"
  ];
  int _selectedIndex = 0;

  _onSelectItem(int index, String menu) {
    setState(() {
      _selectedIndex = index;
      menu_index = menu;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  _onSelectdefaultItem(String menu) {
    setState(() {
      menu_index = menu;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // Provider.of<Controller>(context, listen: false).postRegistration("RONPBQ9AD5D",context);
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).setCname();
    Provider.of<Controller>(context, listen: false).setSname();
    getCompaniId();
    Provider.of<Controller>(context, listen: false).getCompanyData();
  }

  getCompaniId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    print("cid----$cid");
  }

  _getDrawerItemWidget(String pos) {
    print("pos---${pos}");
    switch (pos) {
      case "S1":
        return new MainDashboard();
      case "S2":
        if (widget.type == "return from cartList") {
          return OrderForm(widget.areaName!);
        } else {
          return OrderForm(
            "",
          );
        }
      case "S3":
        return null;
      case "SAC1":
        return null;

      case "S4":
        return null;

      case "S5":
        return null;

      case "SA1":
        return null;

      case "SA2":
        return null;

      case "UL":
        return Uploaddata(
          cid: cid!,
          type: "drawer call",
        );
      case "dP":
        return DownloadedPage(
          type: "drawer call",
        );

      // return DownloadedPage(
      //   type: "drawer call",
      // );
      // case 6:
      //   return Uploaddata(
      //     cid: cid!,
      //     type: "drawer call",
      //   );
      // case 7:
      //   return History(
      //     page: "History Page",
      //   );
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.type == "return from cartList") {
      menu_index = "S1";
    }
    // print("_seletdde---$_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOpts = [];
    print("clicked");
    // companyAttributes.clear();
    for (var i = 0;
        i < Provider.of<Controller>(context, listen: false).menuList.length;
        i++) {
      // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
      drawerOpts.add(Consumer<Controller>(
        builder: (context, value, child) {
          return ListTile(
            title: Text(
              value.menuList[i].menu_name!.toLowerCase(),
              style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
            ),
            selected: i == _selectedIndex,
            onTap: () {
              upselected.value = false;
              dwnselected.value = false;
              _onSelectItem(
                i,
                value.menuList[i].menu_index!,
              );
            },
          );
        },
      ));
    }
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: P_Settings.wavecolor,
        appBar: menu_index == "UL" || menu_index == "dP"
            ? AppBar(
                elevation: 0,
                backgroundColor: P_Settings.wavecolor,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(6.0),
                  child: Consumer<Controller>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          color: P_Settings.wavecolor,

                          // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                          // value: 0.25,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                // title: Text("Company Details",style: TextStyle(fontSize: 20),),
              )
            : AppBar(
                elevation: 0,
                backgroundColor: P_Settings.wavecolor,
                actions: [
                  IconButton(
                    onPressed: () async {
                      List<Map<String, dynamic>> list =
                          await OrderAppDB.instance.getListOfTables();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TableList(list: list)),
                      );
                    },
                    icon: Icon(Icons.table_bar),
                  ),
                ],
              ),
        drawer: Drawer(
          child: LayoutBuilder(builder: (context, snapshot) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // SizedBox(
                  //   height: size.height * 0.0,
                  // ),
                  // Container(
                  //   height: size.height * 0.6,
                  //   width: size.width * 1,
                  //   color: P_Settings.wavecolor,
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         height: size.height * 0.04,
                  //         width: size.width * 0.03,
                  //       ),
                  //       Icon(
                  //         Icons.list_outlined,
                  //         color: Colors.white,
                  //       ),
                  //       SizedBox(width: size.width * 0.04),
                  //       Text(
                  //         "Menus",
                  //         style: TextStyle(fontSize: 20, color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Column(children: drawerOpts),
                  Divider(
                    color: Colors.black,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ValueListenableBuilder(
                      valueListenable: dwnselected,
                      builder:
                          (BuildContext context, bool valueC, Widget? child) {
                        return ListTile(
                          onTap: () async {
                            upselected.value = false;
                            dwnselected.value = true;
                            // _selectedIndex=0;
                            _onSelectdefaultItem("dP");
                          },
                          title: Text(
                            "Download page",
                            style: TextStyle(
                                fontSize: 16,
                                color: valueC ? P_Settings.wavecolor : null),
                          ),
                        );
                      }),
                  ValueListenableBuilder(
                      valueListenable: upselected,
                      builder:
                          (BuildContext context, bool valueD, Widget? child) {
                        return ListTile(
                          onTap: () async {
                            dwnselected.value = false;
                            upselected.value = true;
                            _onSelectdefaultItem("UL");
                          },
                          title: Text(
                            "Upload data",
                            style: TextStyle(
                                fontSize: 16,
                                color: valueD ? P_Settings.wavecolor : null),
                          ),
                        );
                      }),
                  ListTile(
                    trailing: Icon(Icons.logout),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('st_username');
                      await prefs.remove('st_pwd');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StaffLogin()));
                    },
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        body: _getDrawerItemWidget(menu_index),
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
            child: const Text('cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
