import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/6.1_filter_Report.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<Controller>(
                    builder: (context, value, child) {
                      return TextField(
                          decoration: InputDecoration(
                            hintText: "Search with  customer name",
                            hintStyle:
                                TextStyle(fontSize: 14.0, color: Colors.grey),
                            suffixIcon: value.isVisible
                                ? Wrap(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.done,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            // Provider.of<Controller>(context,
                                            //         listen: false)
                                            //     .selectReportFromOrder(context);
                                            Provider.of<Controller>(context,
                                                        listen: false)
                                                    .reportSearchkey =
                                                searchController.text;
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .setreportsearch(true);
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .searchfromreport();
                                          }),
                                      IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            // Provider.of<Controller>(context,
                                            //         listen: false)
                                            //     .getProductList(widget.customerId);
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .setreportsearch(false);

                                            value.setisVisible(false);
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .newreportList
                                                .clear();

                                            searchController.clear();
                                          }),
                                    ],
                                  )
                                : Icon(
                                    Icons.search,
                                    size: 20,
                                  ),
                          ),
                          controller: searchController,
                          onChanged: (value) {
                            Provider.of<Controller>(context, listen: false)
                                .setisVisible(true);
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.05,
                        width: double.infinity,
                        color: P_Settings.collection,
                        child: OutlinedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FilterReport()),
                              );
                            },
                            child: Text("Filters")),
                        // Text("Filters",
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //     )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: size.height * 0.8,
                  child: Consumer<Controller>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Container(
                            // height: size.height * 0.9,
                            width: double.infinity,
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return ListView.builder(
                          itemCount: value.isreportSearch &&
                                  value.newreportList.length > 0
                              ? value.newreportList.length
                              : value.reportData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              value.isreportSearch &&
                                                      value.newreportList
                                                              .length >
                                                          0
                                                  ? value.newreportList[index]
                                                      ["name"]
                                                  : value.reportData[index]
                                                      ["name"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: P_Settings.wavecolor))
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.gps_fixed,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Text(
                                            value.isreportSearch &&
                                                    value.newreportList.length >
                                                        0
                                                ? value.newreportList[index]
                                                    ["ad1"]
                                                : value.reportData[index]
                                                    ["ad1"],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[500],
                                                fontStyle: FontStyle.italic),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      value.isreportSearch &&
                                              value.newreportList.length > 0
                                          ? value.newreportList[index]["mob"] ==
                                                      null ||
                                                  value
                                                      .newreportList[index]
                                                          ["mob"]
                                                      .isEmpty
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Text(
                                                        value.newreportList[
                                                            index]["mob"],
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))
                                                  ],
                                                )
                                          : value.reportData[index]["mob"] ==
                                                      null ||
                                                  value.reportData[index]["mob"]
                                                      .isEmpty
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Text(
                                                        value.reportData[index]
                                                            ["mob"],
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))
                                                  ],
                                                ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.currency_rupee, size: 15),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Text(value.reportData[index]["bln"],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[700])),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Text("(balance)"),
                                          Spacer(),
                                          value.newreportList.length > 0 &&
                                                  value.isreportSearch
                                              ? value.newreportList[index][
                                                              "collection_sum"] !=
                                                          null &&
                                                      value.newreportList[index]
                                                              [
                                                              "collection_sum"] !=
                                                          0
                                                  ? Row(
                                                      children: [
                                                        Icon(Icons
                                                            .currency_rupee),
                                                        Text(value
                                                            .newreportList[
                                                                index][
                                                                "collection_sum"]
                                                            .toString()),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.01,
                                                        ),
                                                        Text("(collection)"),
                                                      ],
                                                    )
                                                  : Container()
                                              : value.reportData[index][
                                                              "collection_sum"] !=
                                                          null &&
                                                      value.reportData[index][
                                                              "collection_sum"] !=
                                                          0
                                                  ? Row(
                                                      children: [
                                                        Icon(
                                                          Icons.currency_rupee,
                                                          size: 16,
                                                        ),
                                                        Text(value
                                                            .reportData[index][
                                                                "collection_sum"]
                                                            .toString()),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.01,
                                                        ),
                                                        Text("(collection)"),
                                                      ],
                                                    )
                                                  : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      value.newreportList.length > 0 &&
                                              value.isreportSearch
                                          ? value.newreportList[index]
                                                          ["order_value"] !=
                                                      null &&
                                                  value.newreportList[index]
                                                          ["order_value"] !=
                                                      0
                                              ? Row(
                                                  children: [
                                                    Icon(Icons.currency_rupee,
                                                        size: 15),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Text(
                                                        value.newreportList[
                                                                index]
                                                                ["order_value"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey[700])),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Text("(order)")
                                                  ],
                                                )
                                              : Container()
                                          : value.reportData[index]
                                                          ["order_value"] !=
                                                      null &&
                                                  value.reportData[index]
                                                          ["order_value"] !=
                                                      0
                                              ? Row(
                                                  children: [
                                                    Icon(Icons.currency_rupee,
                                                        size: 15),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Text(
                                                        value.reportData[index]
                                                                ["order_value"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey[700])),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    Text("(order)")
                                                  ],
                                                )
                                              : Container(),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(children: [
                                        Container(
                                            color: Colors.green,
                                            width: size.width * 0.08,
                                            height: size.height * 0.03,
                                            child: value.isreportSearch &&
                                                    value.newreportList.length >
                                                        0
                                                ? value.newreportList[index][
                                                                "order_value"] !=
                                                            0 &&
                                                        value.newreportList[index][
                                                                "order_value"] !=
                                                            null
                                                    ? Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      )
                                                    : null
                                                : value.reportData[index][
                                                                "order_value"] !=
                                                            0 &&
                                                        value.reportData[index]
                                                                ["order_value"] !=
                                                            null
                                                    ? Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      )
                                                    : null),
                                        Container(
                                          color: P_Settings.wavecolor,
                                          width: size.width * 0.08,
                                          height: size.height * 0.03,
                                          child: value.isreportSearch &&
                                                  value.newreportList.length > 0
                                              ? value.newreportList[index][
                                                              "collection_sum"] !=
                                                          0 &&
                                                      value.newreportList[index]
                                                              [
                                                              "collection_sum"] !=
                                                          null
                                                  ? Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    )
                                                  : null
                                              : value.reportData[index][
                                                              "collection_sum"] !=
                                                          0 &&
                                                      value.reportData[index]
                                                              ["collection_sum"] !=
                                                          null
                                                  ? Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                        ),
                                        Container(
                                          color: P_Settings.roundedButtonColor,
                                          width: size.width * 0.08,
                                          height: size.height * 0.03,
                                          child: value.isreportSearch &&
                                                  value.newreportList.length > 0
                                              ? value.newreportList[index][
                                                              "remark_count"] !=
                                                          0 &&
                                                      value.newreportList[index]
                                                              [
                                                              "remark_count"] !=
                                                          null
                                                  ? Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    )
                                                  : null
                                              : value.reportData[index][
                                                              "remark_count"] !=
                                                          0 &&
                                                      value.reportData[index]
                                                              ["remark_count"] !=
                                                          null
                                                  ? Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 16,
                                            ),
                                            // Text(value.reportData[index]["bln"]-value.reportData[index]["collection_sum"]),
                                            Text("(outstanding)"),
                                          ],
                                        )
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
