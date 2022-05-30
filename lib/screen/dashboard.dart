import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/downloadedPage.dart';
import 'package:orderapp/screen/historypage.dart';
import 'package:orderapp/screen/mainDashboard.dart';
import 'package:orderapp/screen/staffLoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';
import 'orderForm.dart';

class Dashboard extends StatefulWidget {
  String? type;


  String? areaName;
  Dashboard({this.type, this.areaName});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedDrawerIndex = 0;
  List companyAttributes = [
    "Dashboard",
    "Logged in",
    "Collection",
    "Orders",
    "Sale",
    "Download Page","history"
  ];
  int _selectedIndex = 0;

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    // Provider.of<Controller>(context, listen: false).postRegistration("RONPBQ9AD5D",context);
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).setCname();
    Provider.of<Controller>(context, listen: false).setSname();
  }

  _getDrawerItemWidget(int pos) {
    print("pos---${pos}");
    switch (pos) {
      case 0:
        return new MainDashboard();
      case 3:
        if (widget.type == "return from cartList") {
          return OrderForm(widget.areaName!);
        } else {
          return OrderForm("", );
        }
      case 5:
        return DownloadedPage(
          type: "drawer call",
        );

      case 6:return History(page: "History Page",);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.type == "return from cartList") {
      _selectedIndex = 3;
    }
    print("_seletdde---$_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOpts = [];
    print("clicked");
    // companyAttributes.clear();
    for (var i = 0; i < companyAttributes.length; i++) {
      // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
      drawerOpts.add(ListTile(
        title: Text(
          companyAttributes[i],
          style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
        ),
        selected: i == _selectedIndex,
        onTap: () {
          _onSelectItem(i);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => OrderForm()),
          // );
          // Provider.of<Controller>(context, listen: false).getCategoryReportList(
          //     value.reportCategoryList[i].values.elementAt(0));
        },
      )
          // Consumer<Controller>(
          //   builder: (context, value, child) {
          //     return ListTile(
          //       // leading: new Icon(d.icon),
          //       title: Text(
          //         value.reportCategoryList[i].values.elementAt(1),
          //         style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
          //       ),
          //       selected: i == _selectedIndex.value,
          //       onTap: () {
          //         _onSelectItem(
          //             i, value.reportCategoryList[i].values.elementAt(1));
          //         Provider.of<Controller>(context, listen: false)
          //             .getCategoryReportList(
          //                 value.reportCategoryList[i].values.elementAt(0));
          //       },
          //     );
          //   },
          // ),
          );
    }
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: P_Settings.wavecolor,
        appBar: _selectedIndex == 5
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
              ),
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.045,
              ),
              Container(
                height: size.height * 0.2,
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
                trailing: Icon(Icons.logout),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('st_username');
                  await prefs.remove('st_pwd');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => StaffLogin()));
                },
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedIndex),
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
