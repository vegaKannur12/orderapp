import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/dashboard.dart';
import 'package:orderapp/screen/orderForm.dart';
import 'package:orderapp/service/tableList.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  String custmerId;
  String os;
  String areaId;
  String areaname;

  CartList({
    required this.areaId,
    required this.custmerId,
    required this.os,
    required this.areaname,
  });
  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  DateTime now = DateTime.now();
  String? date;
  var sname;
  int counter = 0;
  bool isAdded = false;
  // List<TextEditingController> _controller = [];
  @override
  void initState() {
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    Provider.of<Controller>(context, listen: false).getOrderno();
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false)
        .generateTextEditingController();
    Provider.of<Controller>(context, listen: false)
        .calculateTotal(widget.os, widget.custmerId);
    sname = Provider.of<Controller>(context, listen: false).sname;
    print("sname-----${sname}");
    // _controller = List.generate(length, (i) => TextEditingController());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 1.0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: P_Settings.wavecolor,
          actions: [
            IconButton(
                onPressed: () async {
                  await OrderAppDB.instance
                      .deleteFromTableCommonQuery("orderBagTable", "");
                },
                icon: Icon(Icons.delete)),
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
        body: GestureDetector(onTap: (() {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }), child: Consumer<Controller>(builder: (context, value, child) {
          if (value.isLoading) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.bagList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listItemFunction(
                          value.bagList[index]["cartrowno"],
                          value.bagList[index]["itemName"],
                          value.bagList[index]["rate"],
                          value.bagList[index]["totalamount"],
                          value.bagList[index]["qty"],
                          size,
                          value.controller[index],
                          index,
                          value.bagList[index]["code"]);
                    },
                  ),
                ),
                Container(
                  height: size.height * 0.07,
                  color: Colors.yellow,
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.07,
                        color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" Order Total   : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text("\u{20B9}${value.orderTotal}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (() async {
                          Provider.of<Controller>(context, listen: false)
                              .insertToOrderbagAndMaster(widget.os, date!,
                                  widget.custmerId, sname, widget.areaId);

                          Provider.of<Controller>(context, listen: false)
                                      .bagList
                                      .length >
                                  0
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      value.areDetails.clear();
                                      Navigator.of(context).pop(true);
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                            opaque: false, // set to false
                                            pageBuilder: (_, __, ___) =>
                                                Dashboard(
                                                    type:
                                                        "return from cartList",
                                                    areaName: widget.areaname)
                                            // OrderForm(widget.areaname,"return"),
                                            ),
                                      );
                                    });
                                    return AlertDialog(
                                        content: Row(
                                      children: [
                                        Text(
                                          'Order Placed!!!!',
                                          style: TextStyle(
                                              color: P_Settings.extracolor),
                                        ),
                                        Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        )
                                      ],
                                    ));
                                  })
                              : null;
                          Provider.of<Controller>(context, listen: false)
                              .count = "0";
                          print("area name ${widget.areaname}");
                          // await Future.delayed(
                          //     const Duration(milliseconds: 1000), () {
                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) =>
                          //   //             OrderForm(widget.areaname)));

                          //   // Here you can write your code
                          // });
                        }),
                        child: Container(
                          width: size.width * 0.5,
                          height: size.height * 0.07,
                          color: P_Settings.roundedButtonColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Place Order",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Icon(Icons.shopping_basket)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        })),
      ),
    );
  }

  Widget listItemFunction(
      int cartrowno,
      String itemName,
      String rate,
      String totalamount,
      int qty,
      Size size,
      TextEditingController _controller,
      int index,
      String code) {
    // print("qty-------$qty");
    _controller.text = qty.toString();

    return Container(
      height: size.height * 0.17,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
        child: Ink(
          // color: Colors.grey[100],
          decoration: BoxDecoration(
            color: Colors.grey[100],
            // borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            // leading: CircleAvatar(backgroundColor: Colors.green),
            title: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Container(
                          height: size.height * 0.3,
                          width: size.width * 0.2,
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                            fit: BoxFit.cover,
                          ),
                          color: Colors.grey,
                        ),
                      ),
                      // Text("${id}"),
                      // SizedBox(
                      //   width: size.width * 0.02,
                      // ),
                      // CircleAvatar(
                      //   backgroundColor: Colors.green,
                      //   radius: 40,
                      // ),
                      SizedBox(
                        width: size.width * 0.05,
                        height: size.height * 0.001,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Text(
                                    "${itemName} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: P_Settings.wavecolor),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    " (${code})",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5, top: 3),
                                child: Row(
                                  children: [
                                    Text(
                                      "Rate :",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Text(
                                      "\u{20B9}${rate}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.3,
                                    ),
                                    Flexible(
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              // title: Text("Alert Dialog Box"),
                                              content: Text("delete?"),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: P_Settings
                                                                  .wavecolor),
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text("cancel"),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.01,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: P_Settings
                                                                  .wavecolor),
                                                      onPressed: () async {
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .deleteFromOrderBagTable(
                                                                cartrowno,
                                                                widget
                                                                    .custmerId,
                                                                index);
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text("ok"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 17,
                                        ),
                                        color: P_Settings.extracolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5, top: 3),
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setQty(qty);
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setAmt(totalamount);
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Consumer<Controller>(
                                          builder: (context, value, child) {
                                            return Container(
                                              height: size.height * 0.3,
                                              color: Colors.white,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.center,
                                                    // mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FloatingActionButton
                                                              .small(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                  onPressed:
                                                                      () {
                                                                    value
                                                                        .qtyIncrement();
                                                                    value.totalCalculation(
                                                                        rate);
                                                                  }),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15.0,
                                                                    right: 15),
                                                            child: Text(
                                                              value.qtyinc
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          FloatingActionButton
                                                              .small(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  child: Icon(Icons
                                                                      .remove),
                                                                  onPressed:
                                                                      () {
                                                                    value
                                                                        .qtyDecrement();
                                                                    value.totalCalculation(
                                                                        rate);
                                                                  }),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.02,
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Total Price",
                                                              style: TextStyle(
                                                                  fontSize: 17),
                                                            ),
                                                            Text(
                                                              "\u{20B9}${value.totalPrice.toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 17),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),

                                                      SizedBox(
                                                        height:
                                                            size.height * 0.02,
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height:
                                                                  size.height *
                                                                      0.035,
                                                              width:
                                                                  size.width *
                                                                      0.6,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        // Provider.of<Controller>(context, listen: false).calculateTotal(
                                                                        //     widget
                                                                        //         .os,
                                                                        //     widget
                                                                        //         .custmerId);
                                                                        Provider.of<Controller>(context, listen: false).updateQty(
                                                                            value.qtyinc.toString(),
                                                                            cartrowno,
                                                                            widget.custmerId,
                                                                            rate);

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "continue..")),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                      // ElevatedButton(
                                                      //   child: const Text(
                                                      //       'Close BottomSheet'),
                                                      //   onPressed: () =>
                                                      //       Navigator.pop(context),
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Qty :",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Container(child: Text(qty.toString())),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 182, 179, 179),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total price : ",
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        "\u{20B9}${totalamount}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: P_Settings.extracolor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
