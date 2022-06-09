import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/2_companyDetailsscreen.dart';
import 'package:orderapp/screen/6_collection.dart';
import 'package:orderapp/screen/6_downloadedPage.dart';
import 'package:orderapp/screen/6_historypage.dart';
import 'package:orderapp/screen/5_mainDashboard.dart';
import 'package:orderapp/screen/3_staffLoginScreen.dart';
import 'package:orderapp/screen/6_uploaddata.dart';
import 'package:orderapp/screen/reportPage.dart';
import 'package:orderapp/screen/settings.dart';
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
  List<Widget> drawerOpts = [];

  ValueNotifier<bool> upselected = ValueNotifier(false);
  ValueNotifier<bool> dwnselected = ValueNotifier(false);
  String title = "";
  String? cid;
  String? os;
  String menu_index = "S1";
  List defaultitems = ["upload data", "download page", "logout"];
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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

  _onSelectItem(int index, String? menu) {
    setState(() {
      _selectedIndex = index;
      menu_index = menu!;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  // _onSelectdefaultItem(String menu) {
  //   setState(() {
  //     menu_index = menu;
  //   });
  //   Navigator.of(context).pop();
  // }

  @override
  void initState() {
    // Provider.of<Controller>(context, listen: false).postRegistration("RONPBQ9AD5D",context);
    // TODO: implement initState
    super.initState();
    print("haiiiiii");
    Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();
    Provider.of<Controller>(context, listen: false).setCname();
    Provider.of<Controller>(context, listen: false).setSname();
    // insertSettings();
    getCompaniId();
    // Provider.of<Controller>(context, listen: false).getCompanyData();
    if (Provider.of<Controller>(context, listen: false).firstMenu != null) {
      menu_index = Provider.of<Controller>(context, listen: false).firstMenu!;
    }
  }

  insertSettings() async {
    await OrderAppDB.instance.deleteFromTableCommonQuery("settings", "");
    await OrderAppDB.instance.insertsettingsTable("rate Edit", 0);
  }

  getCompaniId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    os = prefs.getString("os");

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
        // title = "Upload data";
        return Uploaddata(
          title: "Upload data",
          cid: cid!,
          type: "drawer call",
        );
      case "dP":
        // title = "Download data";
        return DownloadedPage(
          title: "Download Page",
          type: "drawer call",
        );
      case "CD":
        // title = "Download data";
        return CompanyDetails(
          type: "drawer call",
        );
      case "RP":
       Provider.of<Controller>(context, listen: false).selectReportFromOrder(context);
        return ReportPage(
          
        );

      case "ST":
        // title = "Download data";
        return Settings();
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();

    if (widget.type == "return from cartList") {
      menu_index = "S2";
    }
    print("dididdd");

    // print("_seletdde---$_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    print("${Provider.of<Controller>(context, listen: false).menuList.length}");
    // List<Widget> drawerOpts = [];
    // print("clicked");
    // // companyAttributes.clear();
    // for (var i = 0;
    //     i < Provider.of<Controller>(context, listen: false).menuList.length;
    //     i++) {
    //   // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
    //   setState(() {
    //     drawerOpts.add(Consumer<Controller>(
    //       builder: (context, value, child) {
    //         return ListTile(
    //           title: Text(
    //             value.menuList[i]["menu_name"].toLowerCase(),
    //             style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
    //           ),
    //           // selected: i == _selectedIndex,
    //           onTap: () {
    //             _onSelectItem(
    //               i,
    //               value.menuList[i]["menu_index"],
    //             );
    //           },
    //         );
    //       },
    //     ));
    //   });
    // }
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        key: _key, //
        backgroundColor: P_Settings.wavecolor,
        appBar: menu_index == "UL" || menu_index == "dP"
            ? AppBar(
                elevation: 0,
                title: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
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
                leading: Builder(
                  builder: (context) => IconButton(
                      icon: new Icon(Icons.menu),
                      onPressed: () {
                        Provider.of<Controller>(context, listen: false)
                            .getCompanyData();
                        // Provider.of<Controller>(context, listen: false)
                        //     .selectFromSettings();
                        // Provider.of<Controller>(context, listen: false)
                        //     .getCompanyData();

                        drawerOpts.clear();
                        print("clicked");
                        // companyAttributes.clear();
                        for (var i = 0;
                            i <
                                Provider.of<Controller>(context, listen: false)
                                    .menuList
                                    .length;
                            i++) {
                          // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
                          setState(() {
                            drawerOpts.add(Consumer<Controller>(
                              builder: (context, value, child) {
                                return ListTile(
                                  title: Text(
                                    value.menuList[i]["menu_name"]
                                        .toLowerCase(),
                                    style: TextStyle(
                                        fontFamily: P_Font.kronaOne,
                                        fontSize: 17),
                                  ),
                                  // selected: i == _selectedIndex,
                                  onTap: () {
                                    _onSelectItem(
                                      i,
                                      value.menuList[i]["menu_index"],
                                    );
                                  },
                                );
                              },
                            ));
                          });
                        }
                        // Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();
                        Scaffold.of(context).openDrawer();
                      }),
                ),
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.045,
                    ),
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 1,
                      color: P_Settings.wavecolor,
                      child: Row(
                        children: [
                          SizedBox(
                            height: size.height * 0.07,
                            width: size.width * 0.03,
                          ),
                          Icon(
                            Icons.list_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: size.width * 0.04),
                          Text(
                            "Menus",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Column(children: drawerOpts),
                    Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      onTap: () async {
                        _onSelectItem(0, "CD");
                      },
                      title: Text(
                        "Company Details",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        _onSelectItem(0, "dP");
                      },
                      title: Text(
                        "Download page",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        _onSelectItem(0, "UL");
                      },
                      title: Text(
                        "Upload data",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    ListTile(
                      trailing: Icon(Icons.settings),
                      onTap: () async {
                        _onSelectItem(0, "ST");
                      },
                      title: Text(
                        "Settings",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        _onSelectItem(0, "RP");
                      },
                      title: Text(
                        "Report",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
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
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
