import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/screen/staffLoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List companyAttributes = ["Logged in", "Collection", "orders", "sale"];
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
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"), backgroundColor: Colors.indigo),
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
          Consumer<Controller>(builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                height: size.height * 0.09,
                child:
                    //  Text("company name: ${(value.c_d[0].cnme == null) && (value.c_d[0].cnme!.isEmpty) ? "null value" : value.c_d[0].cnme}}",
                    Text("hjhjjj",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.headingColor)),
              ),
            );
          }),
          Expanded(
            child: GridView.builder(
              itemCount: companyAttributes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.3,
                crossAxisCount: 2,
              ),
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    decoration: BoxDecoration(),
                    child: Card(
                      // color: Colors.transparent,
                      elevation: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 107, 95, 206),
                              Color.fromARGB(255, 20, 70, 209)
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          // borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        // color: Color.fromARGB(255, 235, 118, 200),
                        height: 40,
                        width: 100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              companyAttributes[index],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "10.00",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.amber),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
