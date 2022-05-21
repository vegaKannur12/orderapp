import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height * 0.12,
          // color: P_Settings.detailscolor2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Flexible(
                  child: Container(
                    height: size.height * 0.03,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date"),
                        Text("Total Order"),
                        Text("Total Amount")
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ListTile(
                  // leading: CircleAvatar(backgroundColor: Colors.green),
                  title: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: size.height * 0.001,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.006,
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(
                                        //   height: size.height * 0.02,
                                        // ),
                                        Text(
                                          "21/12/2022",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text("565"),
                                        Text(
                                          "5678.00",
                                          style: TextStyle(
                                              color: P_Settings.extracolor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
