import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List companyAttributes = [
    "Logged in",
    "Collection",
    "orders",
    "sale"
  ];
  int _selectedIndex = 0;

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // close the drawer
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
      appBar: AppBar(
        backgroundColor: Colors.indigo
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
            Column(children: drawerOpts)
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: size.height * 0.09,
              child: Text("Dashboard",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: P_Settings.headingColor)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: companyAttributes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
              ),
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        // color: P_Settings.wavecolor,
                        ),
                    child: Card(
                      // color: Colors.transparent,
                      elevation: 3,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 102, 190, 171),
                              Color.fromARGB(255, 38, 202, 112)
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          // borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        // color: Color.fromARGB(255, 235, 118, 200),
                        height: 30,
                        width: 100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
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
