import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  List companyAttributes = ["Logged in", "Collection", "Orders", "Sale","Logged in", "Collection", "Orders", "Sale"];
final _random = Random();

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
                          color: Color.fromARGB(
                              _random.nextInt(256),
                              _random.nextInt(250),
                              _random.nextInt(250),
                              _random.nextInt(255)),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '10.00 ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.pink),
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
    );
  }
}
