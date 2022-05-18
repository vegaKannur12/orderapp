import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/listItem.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/productdetails_model.dart';
import 'package:orderapp/screen/cartList.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderForm extends StatefulWidget {
  // const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String? _selectedItem;
  List<Map<String, dynamic>>? newList = [];
  ValueNotifier<int> dtatableRow = ValueNotifier(0);
  TextEditingController eanQtyCon = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController eanTextCon = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();
  List? splitted;
  List? splitted1;
  List<DataRow> dataRows = [];
  String? selected;
  String? productCode;
  String? selectedCus;
  String? common;
  String? custmerId;
  String? staffname;
  bool visible = false;
  String itemName = '';
  String? rate1;
  // double rate1 = 0.0;
  bool isAdded = false;
  int selectedIndex = 0;
  int _randomNumber1 = 0;
  bool dropvisible = true;
  String randnum = "";
  int num = 0;
  DateTime now = DateTime.now();
  String? date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    sharedPref();
    if (splitted == null || splitted!.isEmpty) {
      splitted = ["", ""];
    }
  }

  // void onChange() {
  //   num = num + 1;
  //   print("Numsssssssss$num");
  // }

  sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    staffname = prefs.getString('st_username');
    print("staffname---${staffname}");
    Provider.of<Controller>(context, listen: false).getArea(staffname!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<Controller>(builder: (context, values, child) {
              // print("value.areaList-----${values.areaList}");
              // print("value.custmer-----${values.customerList}");

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Ink(
                      decoration:
                          BoxDecoration(color: P_Settings.orderFormcolor),
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(
                              Icons.person,
                              // color: Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              "CUSTOMER",
                              // style: TextStyle(color: Colors.white
                              // ),
                            ),
                          ],
                        ),
                        // trailing: IconButton(
                        //   icon: Icon(
                        //     visible ? Icons.arrow_upward : Icons.arrow_downward,
                        //     color: Colors.black,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       visible = !visible;
                        //     });
                        //   },
                        // ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        height: size.height * 0.22,
                        color: Colors.white,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Area/Route",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 14.0, right: 40),
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 4),
                                          border:
                                              OutlineInputBorder(gapPadding: 1),
                                          hintText: "Select..",
                                        ),
                                        child: Autocomplete<String>(
                                          optionsBuilder:
                                              (TextEditingValue value) {
                                            if (value.text.isEmpty) {
                                              return [];
                                            } else {
                                              print(
                                                  "TextEditingValue---${value.text}");
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .getArea(value.text);

                                              return values.areDetails;
                                            }
                                          },
                                          onSelected: (value) {
                                            // Provider.of<Controller>(context,
                                            //           listen: false).custmerDetails.clear();
                                            setState(() {
                                              _selectedItem = value;
                                              print(
                                                  "_selectedItem---${_selectedItem}");
                                              splitted =
                                                  _selectedItem!.split('-');
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: size.width * 0.4),
                                  Flexible(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          print("helooo");
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .custmerDetails
                                              .clear();
                                          setState(() {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .getCustomer(splitted![0]);
                                          });
                                        },
                                        child: Text("Ok")),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Customer",
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 28, right: 110),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 4),
                                        border:
                                            OutlineInputBorder(gapPadding: 1),
                                        hintText: "Select..",
                                      ),
                                      child: Autocomplete<Map<String, dynamic>>(
                                        optionsBuilder:
                                            (TextEditingValue value) {
                                          if (value.text.isEmpty) {
                                            return [];
                                          } else {
                                            print(
                                                "TextEditingValue---${value.text}");
                                            // Provider.of<Controller>(context,
                                            //         listen: false)
                                            //     .getCustomer(value.text);
                                            return values.custmerDetails;
                                          }
                                        },
                                        displayStringForOption:
                                            (Map<String, dynamic> option) =>
                                                option["hname"],
                                        onSelected: (value) {
                                          setState(() {
                                            print("value----${value}");
                                            _selectedItem = value["hname"];
                                            custmerId = value["code"];
                                            print(
                                                "Code .........---${custmerId}");
                                          });
                                        },
                                        optionsViewBuilder:
                                            (BuildContext context,
                                                AutocompleteOnSelected<
                                                        Map<String, dynamic>>
                                                    onSelected,
                                                Iterable<Map<String, dynamic>>
                                                    options) {
                                          return Align(
                                            alignment: Alignment.topLeft,
                                            child: Material(
                                              child: Container(
                                                width: size.width * 0.7,
                                                // color: Colors.teal,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.all(10.0),
                                                  itemCount: options.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    //      print(
                                                    // "option----${options}");
                                                    print("index----${index}");
                                                    final Map<String, dynamic>
                                                        option = options
                                                            .elementAt(index);
                                                    print(
                                                        "option----${option}");
                                                    return ListTile(
                                                      onTap: () {
                                                        print(
                                                            "optonsssssssssssss$option");
                                                        onSelected(option);
                                                      },
                                                      title: Text(
                                                          option["hname"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  // Flexible(
                                  //   flex: 4,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         left: 25, right: 110),
                                  //     child: InputDecorator(
                                  //       decoration: InputDecoration(
                                  //         contentPadding: EdgeInsets.symmetric(
                                  //             vertical: 0, horizontal: 4),
                                  //         border:
                                  //             OutlineInputBorder(gapPadding: 1),
                                  //         hintText: "Select..",
                                  //       ),
                                  //       child: Autocomplete<String>(
                                  //         optionsBuilder:
                                  //             (TextEditingValue value) {
                                  //           if (value.text.isEmpty) {
                                  //             return [];
                                  //           } else {
                                  //             print(
                                  //                 "TextEditingValue---${value.text}");
                                  //             Provider.of<Controller>(context,
                                  //                     listen: false)
                                  //                 .getCustomer(value.text);
                                  //             return values.custmerDetails;
                                  //           }
                                  //         },
                                  //         onSelected: (value) {
                                  //           setState(() {
                                  //             _selectedItem = value;
                                  //             print(
                                  //                 "_selectedItem---${_selectedItem}");
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        debugPrint('Card tapped.');
                      },
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.grey[300],
                            color: P_Settings.orderFormcolor,
                            width: size.width * 0.95,
                            height: size.height * 0.06,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text('Orderform'),
                                  SizedBox(
                                    width: size.width * 0.3,
                                  ),
                                  Text('History'),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor:
                                        Color.fromARGB(255, 199, 88, 199),
                                    child: const Text('0'),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: size.height * 0.04,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text("ORDER NO:  "),
                                  Text(
                                    values.ordernum.length != 0 &&
                                            values.ordernum[0]['os'] != null &&
                                            values.ordernum.isNotEmpty
                                        ? values.ordernum[0]['os']
                                        : "1",
                                    style:
                                        TextStyle(color: P_Settings.extracolor),
                                  ),
                                  // Text(
                                  //   '\u{20B9}${0}',
                                  //   style: TextStyle(color: Colors.red),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.2,
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Choose Category",
                                        style: TextStyle(
                                            color: P_Settings.chooseCategory),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.4,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: InputDecorator(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 4),
                                            border: OutlineInputBorder(
                                                gapPadding: 1),
                                            hintText: "Select..",
                                          ),
                                          child: Autocomplete<
                                              Map<String, dynamic>>(
                                            optionsBuilder:
                                                (TextEditingValue value) {
                                              if (value.text.isEmpty) {
                                                return [];
                                              } else {
                                                print(
                                                    "TextEditingValue---${value.text}");
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .getProductItems(
                                                        value.text);
                                                return values.productName;
                                              }
                                            },
                                            displayStringForOption:
                                                (Map<String, dynamic> option) =>
                                                    option["code"] +
                                                    '-' +
                                                    option["item"],
                                            onSelected: (value) {
                                              setState(() {
                                                print("value----${value}");
                                                _selectedItem = value["item"];
                                                itemName = value["item"];
                                                productCode = value["code"];
                                                rate1 = value["rate1"];
                                                print(
                                                    "_selectedItem---${_selectedItem}");
                                              });
                                            },
                                            optionsViewBuilder: (BuildContext
                                                    context,
                                                AutocompleteOnSelected<
                                                        Map<String, dynamic>>
                                                    onSelected,
                                                Iterable<Map<String, dynamic>>
                                                    options) {
                                              return Align(
                                                alignment: Alignment.topLeft,
                                                child: Material(
                                                  child: Container(
                                                    width: size.width * 0.7,
                                                    // color: Colors.teal,
                                                    child: ListView.builder(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      itemCount: options.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        //      print(
                                                        // "option----${options}");
                                                        print(
                                                            "index----${index}");
                                                        final Map<String,
                                                                dynamic>
                                                            option =
                                                            options.elementAt(
                                                                index);
                                                        print(
                                                            "option----${option}");
                                                        return ListTile(
                                                          trailing: Wrap(
                                                            children: [
                                                              // Container(
                                                              //   width:
                                                              //       size.width *
                                                              //           0.09,
                                                              //   child:
                                                              //       TextFormField(
                                                              //     decoration:
                                                              //         InputDecoration(
                                                              //             hintText:
                                                              //                 'Qty'),
                                                              //     style: TextStyle(
                                                              //         fontWeight:
                                                              //             FontWeight
                                                              //                 .bold,
                                                              //         fontSize:
                                                              //             16),
                                                              //     keyboardType:
                                                              //         TextInputType
                                                              //             .number,
                                                              //     controller:
                                                              //         qty,
                                                              //     onChanged:
                                                              //         (value) {
                                                              //       value = qty
                                                              //           .text;
                                                              //     },
                                                              //   ),
                                                              // ),
                                                              IconButton(
                                                                icon: Icon(
                                                                    Icons.add),
                                                                onPressed:
                                                                    () async {
                                                                  String item =
                                                                      option[
                                                                          "item"];
                                                                  String rate1 =
                                                                      option[
                                                                          "rate1"];
                                                                  String
                                                                      productCode =
                                                                      option[
                                                                          "code"];
                                                                  print(
                                                                      "option[code]----$productCode");
                                                                  print(
                                                                      "item----rate---${option["item"]}---${option["rate1"]}");
                                                                  int max = await OrderAppDB
                                                                      .instance
                                                                      .getMaxOfFieldValue(
                                                                          values.ordernum[0]
                                                                              [
                                                                              'os'],
                                                                          custmerId!);
                                                                  var res = await OrderAppDB
                                                                      .instance
                                                                      .insertorderBagTable(
                                                                          item,
                                                                          date!,
                                                                          values.ordernum[0]
                                                                              [
                                                                              'os'],
                                                                          custmerId!,
                                                                          max,
                                                                          productCode,
                                                                          1,
                                                                          rate1,
                                                                          "",
                                                                          0);
                                                                  Provider.of<Controller>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .listWidget
                                                                      .add({
                                                                    "item":
                                                                        item,
                                                                    "rate1":
                                                                        rate1
                                                                  });
                                                                  Provider.of<Controller>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .gettotalSum();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          onTap: () {
                                                            onSelected(option);
                                                          },
                                                          title: Text(
                                                              option["code"] +
                                                                  '-' +
                                                                  option["item"]
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.04,
                                      ),
                                      Container(
                                        width: size.width * 0.09,
                                        child: TextFormField(
                                          decoration:
                                              InputDecoration(hintText: 'Qty'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          keyboardType: TextInputType.number,
                                          controller: qty,
                                          onChanged: (value) {
                                            value = qty.text;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            print(
                                                " itemName, rate1--${itemName}--${rate1}");
                                            var max = await OrderAppDB.instance
                                                .getMaxOfFieldValue(
                                                    values.ordernum[0]['os'],
                                                    custmerId!);
                                            var total = int.parse(rate1!) *
                                                int.parse(qty.text);
                                            print("total rate $total");
                                            var res = await OrderAppDB.instance
                                                .insertorderBagTable(
                                                    itemName,
                                                    date!,
                                                    values.ordernum[0]['os'],
                                                    custmerId!,
                                                    max,
                                                    productCode!,
                                                    int.parse(qty.text),
                                                    rate1!,
                                                    total.toString(),
                                                    0);
                                            var res1 = await OrderAppDB.instance
                                                .gettotalSum();
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .gettotalSum();
                                         
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                P_Settings.roundedButtonColor,
                                            // shape: CircleBorder(),
                                          ),
                                          child: Icon(Icons.add,
                                              size: 20, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                        label: Text("View bag"),
                                        onPressed: () async {
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .getBagDetails(custmerId!);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CartList(
                                                      custmerId: custmerId!,
                                                    )),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.01,
                            color: Colors.grey[300],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              height: size.height * 0.2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.359,
                                      ),
                                      Text("Total items:"),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Text(""),
                                      // Flexible(
                                      //   child: TextField(
                                      //     readOnly: true,
                                      //     decoration: InputDecoration(
                                      //         // border: UnderlineInputBorder(
                                      //         //   borderSide: BorderSide(
                                      //         //       color: Color.fromARGB(
                                      //         //           255, 11, 177, 38)),
                                      //         // ),
                                      //         ),
                                      //     onChanged: (value) {},
                                      //   ),
                                      // ),
                                      // Icon(Icons.shopping_cart, size: 19),
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.25,
                                        height: size.height * 0.04,
                                      ),
                                      Text("Approximate Total : "),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Flexible(
                                          child: Text(""
                                              // values.approximateSum.length != 0 &&
                                              //         values.approximateSum[0]
                                              //                 ['s'] !=
                                              //             null &&
                                              //         values.approximateSum.isNotEmpty
                                              //     ? values.approximateSum[0]['s']
                                              //     : "0.00",
                                              )
                                          // values.approximateSum
                                          //               .length !=
                                          //           0 &&
                                          //       values.approximateSum[0]
                                          //               ['rate'] !=
                                          //           null &&
                                          //       values.approximateSum.isNotEmpty
                                          //   ? values.approximateSum[0]['rate']
                                          //   : values.approximateSum[0]['rate']
                                          //   ),

                                          ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(height: size.height * 0.03),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Save"),
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  P_Settings.chooseCategory,
                                            ))
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
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget dropDown1(List<Map<String, dynamic>> items, String type, Size size) {
    print("value.area-----${items}");
    return Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16),
        child: Center(
          child: Container(
            height: size.height * 0.045,
            width: size.width * 0.75,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: P_Settings.orderFormcolor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            child: DropdownButton<String>(
              hint: Text("Select"),
              isExpanded: true,
              autofocus: false,
              underline: SizedBox(),
              elevation: 0,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                      value: item["aid"].toString(),
                      child: Container(
                        width: size.width * 0.5,
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(item["aname"].toString())),
                      )))
                  .toList(),
              onChanged: (item) {
                // Provider.of<Controller>(context, listen: false)
                //     .customerList
                //     .length = 0;
                print("clicked");

                if (item != null) {
                  setState(() {
                    selected = item;
                    print("selected area..........${selected}");
                  });
                }
                // Provider.of<Controller>(context, listen: false).getArea(selected!);
              },
              value: selected,
              // disabledHint: Text(selected ?? "null"),
            ),
          ),
        ));
  }

  //////////////////////////////////////////////////////////
  Widget dropDown2(List<Map<String, dynamic>> customr, String type, Size size) {
    // print("value.custmer-----${items}");
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Center(
          child: Container(
            height: size.height * 0.045,
            width: size.width * 0.75,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: P_Settings.orderFormcolor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            child: DropdownButton<String>(
              // disabledHint: customr.isEmpty || customr == null ? Text("Select") : null,
              hint: Text("Select"),
              // dropdownColor: Colors.transparent,
              isExpanded: true,
              autofocus: false,
              underline: SizedBox(),
              elevation: 0,
              // value: "INDIA",
              items: customr
                  .map((cust) => DropdownMenuItem<String>(
                      value: cust["code"].toString(),
                      child: Container(
                        width: size.width * 0.5,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(cust["hname"].toString())),
                      )))
                  .toList(),

              onChanged: (cust) {
                if (cust != null) {
                  setState(() {
                    selectedCus = cust;
                    print("selected cus..........${selected}");
                  });
                }
              },
              value: selectedCus,
            ),
          ),
        ));
  }
}