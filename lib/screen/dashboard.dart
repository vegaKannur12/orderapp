import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/screen/staffLoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';
import 'orderForm.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List companyAttributes = ["Logged in", "Collection", "Orders", "Sale"];
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderForm()),
          );
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
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0,
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
        body: Column(
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
                                    color: P_Settings.headingColor)),
                            SizedBox(
                              height: 15,
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
            Expanded(
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
                      childAspectRatio: 1.3,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
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
                              color: Color.fromARGB(255, 115, 158, 233),
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
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '10.00 ',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.pink),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
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
