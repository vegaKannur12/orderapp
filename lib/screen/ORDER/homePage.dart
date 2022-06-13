import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class HomeWidget {
  Widget home(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<Controller>(
      builder: (context, value, child) {
        return Container(
          child: Column(
            children: [
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
                            backgroundColor: Color.fromARGB(255, 214, 201, 200),
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
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Todays",
                  style: TextStyle(
                      fontSize: 20,
                      color: P_Settings.wavecolor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: P_Settings.detailscolor),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Text(
                                          "${value.collectionCount.length != 0 && value.collectionCount[0]['S'] != null && value.collectionCount.isNotEmpty ? value.collectionCount[0]['S'] : "0"}",
                                          style: TextStyle(
                                              color: P_Settings.detailscolor,
                                              fontSize: 15),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: P_Settings.detailscolor),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Text(
                                          "${value.orderCount.length != 0 && value.orderCount[0]['S'] != null && value.orderCount.isNotEmpty ? value.orderCount[0]['S'] : "0"}",
                                          style: TextStyle(
                                              color: P_Settings.detailscolor,
                                              fontSize: 15),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl2,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Sales",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl1,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Return",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "",
                                            style: TextStyle(
                                                color: P_Settings.detailscolor,
                                                fontSize: 15),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl3,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Sales",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl2,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Return",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "",
                                            style: TextStyle(
                                                color: P_Settings.detailscolor,
                                                fontSize: 15),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl1,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Collection",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "\u{20B9}${value.collectionsumPrice.length != 0 && value.collectionsumPrice[0]['S'] != null && value.collectionsumPrice.isNotEmpty ? value.collectionsumPrice[0]['S'] : "0"}",
                                            style: TextStyle(
                                                color: P_Settings.detailscolor,
                                                fontSize: 15),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
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
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "\u{20B9}${value.sumPrice.length != 0 && value.sumPrice[0]['s'] != null && value.sumPrice.isNotEmpty ? value.sumPrice[0]['s'] : "0"}",
                                            style: TextStyle(
                                                color: P_Settings.detailscolor,
                                                fontSize: 15),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Sales",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      P_Settings.detailscolor),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl1,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Return",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "",
                                            style: TextStyle(
                                                color: P_Settings.detailscolor,
                                                fontSize: 15),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Sales",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      P_Settings.detailscolor),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl2,
                                    ),
                                    height: size.height * 0.1,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Return",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: P_Settings.detailscolor),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Text(
                                            "",
                                            style: TextStyle(
                                                color: P_Settings.extracolor,
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
        );
      },
    );
  }
}
