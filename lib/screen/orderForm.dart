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

import '../components/customPopup.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderForm extends StatefulWidget {
  // const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String? _selectedItemarea;
  CustomPopup popup = CustomPopup();
  String? _selectedItemcus;
  String? _selectedItem;

  List<Map<String, dynamic>>? newList = [];
  ValueNotifier<int> dtatableRow = ValueNotifier(0);
  ValueNotifier<bool> visibleValidation = ValueNotifier(false);

  TextEditingController eanQtyCon = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController eanTextCon = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
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
  String rate1 = "1";
  // double rate1 = 0.0;
  bool isAdded = false;
  bool alertvisible = false;
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
        reverse: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<Controller>(builder: (context, values, child) {
              // print("value.areaList-----${values.areaList}");
              // print("value.custmer-----${values.customerList}");

              return Form(
                key: formGlobalKey,
                child: Column(
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
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Area/Route",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 15),
                                child: Container(
                                  height: size.height * 0.05,
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 4),
                                      border: OutlineInputBorder(gapPadding: 1),
                                      hintText: "Select..",
                                    ),
                                    child: Autocomplete<String>(
                                        // initialValue: ,
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

                                        return values.areDetails.where(
                                            (suggestion) => suggestion
                                                .toLowerCase()
                                                .contains(
                                                    value.text.toLowerCase()));
                                      }
                                    }, onSelected: (value) {
                                      setState(() {
                                        _selectedItemarea = value;
                                        print(
                                            "_selectedItem---${_selectedItemarea}");
                                        splitted =
                                            _selectedItemarea!.split('-');

                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getCustomer(splitted![0]);
                                      });
                                    }, fieldViewBuilder: (BuildContext context,
                                            TextEditingController
                                                fieldTextEditingController,
                                            FocusNode fieldFocusNode,
                                            VoidCallback onFieldSubmitted) {
                                      return TextField(
                                        decoration: InputDecoration(
                                          // hintText: 'Enter a message',
                                          suffixIcon: IconButton(
                                            onPressed:
                                                fieldTextEditingController
                                                    .clear,
                                            icon: Icon(Icons.clear),
                                          ),
                                        ),
                                        controller: fieldTextEditingController,
                                        focusNode: fieldFocusNode,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      );
                                    }),
                                  ),
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
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.height * 0.05,
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 4),
                                          border:
                                              OutlineInputBorder(gapPadding: 1),
                                          hintText: "Select..",
                                        ),
                                        child:
                                            Autocomplete<Map<String, dynamic>>(
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
                                              _selectedItemcus = value["hname"];
                                              custmerId = value["code"];
                                              print(
                                                  "Code .........---${custmerId}");
                                            });
                                          },
                                          fieldViewBuilder: (BuildContext
                                                  context,
                                              TextEditingController
                                                  fieldTextEditingController,
                                              FocusNode fieldFocusNode,
                                              VoidCallback onFieldSubmitted) {
                                            return TextFormField(
                                              // validator: (val) => val!.isEmpty
                                              //     ? 'Please select customer...'
                                              //     : null,
                                              controller:
                                                  fieldTextEditingController,
                                              decoration: InputDecoration(
                                                // hintText: 'Enter a message',
                                                suffixIcon: IconButton(
                                                  onPressed:
                                                      fieldTextEditingController
                                                          .clear,
                                                  icon: Icon(Icons.clear),
                                                ),
                                              ),
                                              focusNode: fieldFocusNode,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            );
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
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    itemCount: options.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      //      print(
                                                      // "option----${options}");
                                                      print(
                                                          "index----${index}");
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
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: visibleValidation,
                                        builder: (BuildContext context, bool v,
                                            Widget? child) {
                                          // print("value===${visible.value}");
                                          return Visibility(
                                            visible: v,
                                            child: Text(
                                              "Please choose Customer!!!",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          );
                                        })
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
                                              values.ordernum[0]['os'] !=
                                                  null &&
                                              values.ordernum.isNotEmpty
                                          ? values.ordernum[0]['os']
                                          : "1",
                                      style: TextStyle(
                                          color: P_Settings.extracolor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.2,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisAlignment: ,
                                      children: [
                                        Text(
                                          "Choose Category",
                                          style: TextStyle(
                                              color: P_Settings.chooseCategory),
                                        ),
                                        Spacer(),
                                        ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                            size: 30.0,
                                          ),
                                          label: Text("View bag"),
                                          onPressed: () async {
                                            if (_selectedItemcus == null ||
                                                _selectedItemcus!.isEmpty) {
                                              visibleValidation.value = true;
                                            } else {
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .getBagDetails(custmerId!,
                                                      values.ordernum[0]['os']);
                                              visibleValidation.value = false;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartList(
                                                          areaId: splitted![0],
                                                          custmerId: custmerId!,
                                                          os: values.ordernum[0]
                                                              ['os'],
                                                        )),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: P_Settings.wavecolor,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Container(
                                            height: size.height * 0.04,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  alertvisible = !alertvisible;
                                                });
                                                if (qty.text == null ||
                                                    qty.text.isEmpty) {
                                                  qty.text = "1";
                                                }
                                                print(
                                                    " itemName, rate1--${itemName}--${rate1}");
                                                int max = await OrderAppDB
                                                    .instance
                                                    .getMaxCommonQuery(
                                                        'orderBagTable',
                                                        'cartrowno',
                                                        "os='${values.ordernum[0]["os"]}' AND customerid='$custmerId'");
                                                var total = int.parse(rate1) *
                                                    int.parse(qty.text);
                                                print("total rate $total");
                                                var res = custmerId == null ||
                                                        custmerId!.isEmpty ||
                                                        selectedCus == null ||
                                                        selectedCus!.isEmpty ||
                                                        productCode == null ||
                                                        productCode!.isEmpty
                                                    ? visibleValidation.value =
                                                        true
                                                    : await OrderAppDB.instance
                                                        .insertorderBagTable(
                                                            itemName,
                                                            date!,
                                                            values.ordernum[0]
                                                                ['os'],
                                                            custmerId!,
                                                            max,
                                                            productCode!,
                                                            int.parse(qty.text),
                                                            rate1,
                                                            total.toString(),
                                                            0);
                                                print("result........... $res");
                                                //  Provider.of<Controller>(context,
                                                //           listen: false).countFromTable("orderBagTable");
                                                custmerId == null ||
                                                        custmerId!.isEmpty ||
                                                        productCode == null ||
                                                        productCode!.isEmpty
                                                    ? Text("Select customer")
                                                    : Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .calculateTotal(
                                                            values.ordernum[0]
                                                                ['os'],
                                                            custmerId!);

                                                /////////////////////////

                                              alertvisible?  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      Future.delayed(
                                                          Duration(milliseconds: 400),
                                                          () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      });
                                                      return AlertDialog(
                                                        content: Text(
                                                          'Added to cart',
                                                          style: TextStyle(
                                                              color: P_Settings
                                                                  .extracolor),
                                                        ),
                                                      );
                                                    }):Text("No data");
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: P_Settings
                                                    .roundedButtonColor,
                                                // shape: CircleBorder(),
                                              ),
                                              child: Icon(Icons.add,
                                                  size: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: size.height * 0.05,
                                          width: size.width * 0.7,
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 4),
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
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .getProductItems(
                                                          value.text);
                                                  return values.productName;
                                                }
                                              },
                                              fieldViewBuilder: (BuildContext
                                                  context,
                                              TextEditingController
                                                  fieldTextEditingController,
                                              FocusNode fieldFocusNode,
                                              VoidCallback onFieldSubmitted) {
                                            return TextFormField(
                                              // validator: (val) => val!.isEmpty
                                              //     ? 'Please select customer...'
                                              //     : null,
                                              controller:
                                                  fieldTextEditingController,
                                                  
                                              decoration: InputDecoration(
                                                // hintText: 'Enter a message',
                                                suffixIcon: IconButton(
                                                  
                                                  onPressed:() =>  
                                                   fieldTextEditingController
                                                          .clear,
                                                  // Provider.of<Controller>(context,
                                                  //                   listen: false).prodctItems.clear() ,
                                                     
                                                     
                                                  icon: Icon(Icons.clear),
                                                ),
                                              ),
                                              focusNode: fieldFocusNode,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            );
                                          },
                                              displayStringForOption:
                                                  (Map<String, dynamic>
                                                          option) =>
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
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                        itemCount:
                                                            options.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
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
                                                                      Icons
                                                                          .add),
                                                                  onPressed:
                                                                      () async {
                                                                    String
                                                                        item =
                                                                        option[
                                                                            "item"];
                                                                    String
                                                                        rate1 =
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
                                                                    if (qty.text ==
                                                                            null ||
                                                                        qty.text
                                                                            .isEmpty) {
                                                                      qty.text =
                                                                          "1";
                                                                    }
                                                                    int max = await OrderAppDB
                                                                        .instance
                                                                        .getMaxCommonQuery(
                                                                            'orderBagTable',
                                                                            'cartrowno',
                                                                            "os='${values.ordernum[0]["os"]}' AND customerid='$custmerId'");
                                                                    var total = int.parse(
                                                                            rate1) *
                                                                        int.parse(
                                                                            qty.text);

                                                                    print(
                                                                        "total rate $total");
                                                                    var res = await OrderAppDB.instance.insertorderBagTable(
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
                                                                        total
                                                                            .toString(),
                                                                        0);
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          Future.delayed(
                                                                              Duration(milliseconds: 500),
                                                                              () {
                                                                            Navigator.of(context).pop(true);
                                                                          });
                                                                          return AlertDialog(
                                                                            content:
                                                                                Text(
                                                                              'Added to cart',
                                                                              style: TextStyle(color: P_Settings.extracolor),
                                                                            ),
                                                                          );
                                                                        });
                                                                    //                        Provider.of<Controller>(context,
                                                                    // listen: false).countFromTable("orderBagTable");
                                                                    //               Provider.of<Controller>(
                                                                    //                       context,
                                                                    //                       listen:
                                                                    //                           false).calculateTotal(values.ordernum[0]
                                                                    //                           [
                                                                    //                           'os'],custmerId! );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            onTap: () {
                                                              onSelected(
                                                                  option);
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
                                            decoration: InputDecoration(
                                                hintText: 'Qty'),
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
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
                                height: size.height * 0.1,
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
                                        Text(
                                            "${Provider.of<Controller>(context, listen: false).count}"),
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
                                          width: size.width * 0.06,
                                        ),
                                        Flexible(
                                            child: Text(
                                                "\u{20B9}${Provider.of<Controller>(context, listen: false).orderTotal}"
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
                                    // Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       SizedBox(height: size.height * 0.03),
                                    //       ElevatedButton(
                                    //           onPressed: () {},
                                    //           child: Text("Save"),
                                    //           style: ElevatedButton.styleFrom(
                                    //             primary:
                                    //                 P_Settings.chooseCategory,
                                    //           ))
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
