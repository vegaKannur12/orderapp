import 'dart:developer';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/listItem.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/productdetails_model.dart';
import 'package:orderapp/screen/cartList.dart';
import 'package:orderapp/screen/historypage.dart';
import 'package:orderapp/screen/itemSelection.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../components/customPopup.dart';
import '../components/customSnackbar.dart';
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
  CustomSnackbar snackbar = CustomSnackbar();
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
      backgroundColor: P_Settings.bodycolor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Consumer<Controller>(builder: (context, values, child) {
            return Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  // SizedBox(height: size.height * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                          color: P_Settings.wavecolor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person, color: P_Settings.bottomColor,
                                // color: Colors.white,
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text("CUSTOMER",
                                  style: TextStyle(
                                      color: P_Settings.bodycolor,
                                      fontWeight: FontWeight.bold)
                                  // ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height * 0.35,
                          color: Colors.white,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.01),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
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
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Customer",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
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
                                      height: size.height * 0.01,
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
                                        }),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 100, right: 100),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: size.height * 0.045,
                                            child: ElevatedButton.icon(
                                              icon: Icon(
                                                Icons.library_add_check,
                                                color: Colors.white,
                                                size: 30.0,
                                              ),
                                              label: Text("Add Items"),
                                              onPressed: () async {
                                                FocusScopeNode currentFocus =
                                                    FocusScope.of(context);

                                                if (!currentFocus
                                                    .hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                                if (custmerId == null ||
                                                    custmerId!.isEmpty) {
                                                  visibleValidation.value =
                                                      true;
                                                } else {
                                                  print(
                                                      "values.isLoading---${values.isLoading}");

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ItemSelection()));
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: P_Settings.wavecolor,
                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          10.0),
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
                              // Column(
                              //   children: [
                              //     Container(
                              //       height: size.height * 0.2,
                              //       alignment: Alignment.topLeft,
                              //       child: Padding(
                              //         padding: const EdgeInsets.only(left: 10),
                              //         child:
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////

}
