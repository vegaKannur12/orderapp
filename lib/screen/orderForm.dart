import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/itemSelection.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/customPopup.dart';
import '../components/customSnackbar.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderForm extends StatefulWidget {
  String areaname;
  String isPlaced;

  OrderForm(
    this.areaname,
    this.isPlaced
  );

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> with TickerProviderStateMixin {
  TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingValue textvalue = TextEditingValue();
  bool isLoading = false;
  String? _selectedItemarea;
  String? area;
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
  TextEditingController fieldText = TextEditingController();
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
  }

  sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    staffname = prefs.getString('st_username');
    print("staffname---${staffname}");
    Provider.of<Controller>(context, listen: false).getArea(staffname!);
  }

  @override
  Widget build(BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;
    String? _selectedItemarea;
    String? _selectedAreaId;
    print("widget.areaname---${widget.areaname}");
    // final bottom = MediaQuery.of(context).viewInsets.bottom;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            // reverse: true,
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
                            height: size.height * 0.24,
                            decoration: BoxDecoration(
                              color: P_Settings.wavecolor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person, color: P_Settings.bottomColor,
                                    size: 30,
                                    // color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text("CUSTOMER",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: P_Settings.bodycolor,
                                          fontWeight: FontWeight.bold)
                                      // ),
                                      ),
                                ]),
                          ),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height * 0.9,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: size.height * 0.01),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
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
                                      height: size.height * 0.06,
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            gapPadding: 1,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 3,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 4),
                                          hintText: widget.areaname,
                                        ),
                                        child:
                                            Autocomplete<Map<String, dynamic>>(
                                          initialValue: TextEditingValue(
                                              text: widget.areaname),
                                          optionsBuilder:
                                              (TextEditingValue value) {
                                            if (value.text.isEmpty) {
                                              return [];
                                            } else {
                                              print(
                                                  "TextEditingValue---${value.text}");

                                              print(
                                                  "values.areDetails----${values.areDetails}");
                                              return values.areDetails.where(
                                                  (suggestion) =>
                                                      suggestion["aname"]
                                                          .toLowerCase()
                                                          .contains(value.text
                                                              .toLowerCase()));
                                            }
                                          },
                                          displayStringForOption:
                                              (Map<String, dynamic> option) =>
                                                  option["aname"],

                                          onSelected: (value) {
                                            setState(() {
                                              _selectedItemarea =
                                                  value["aname"];
                                              _selectedAreaId = value["aid"];
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .areaAutoComplete = [
                                                _selectedAreaId!,
                                                _selectedItemarea!,
                                              ];
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .getCustomer(
                                                      _selectedAreaId!);
                                            });
                                          },
                                          fieldViewBuilder: (BuildContext
                                                  context,
                                              areaController,
                                              FocusNode fieldFocusNode,
                                              VoidCallback onFieldSubmitted) {
                                            return TextField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,

                                                // hintText: 'Enter a message',
                                                suffixIcon: IconButton(
                                                  onPressed:
                                                      areaController.clear,
                                                  icon: Icon(Icons.clear),
                                                ),
                                              ),
                                              controller: areaController,
                                              // scrollPadding: EdgeInsets.only(
                                              //     bottom: topInsets + 100.0),
                                              focusNode: fieldFocusNode,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            );
                                          },
                                          // optionsMaxHeight: size.height * 0.3,
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
                                                  height: size.height * 0.2,
                                                  width: size.width * 0.84,
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
                                                            option["aname"]
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
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: size.height * 0.06,
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 4),
                                              border: OutlineInputBorder(
                                                gapPadding: 1,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 3,
                                                ),
                                              ),
                                              // hintText: "Select..",
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

                                                  return values.custmerDetails
                                                      .where((suggestion) =>
                                                          suggestion["hname"]
                                                              .toLowerCase()
                                                              .startsWith(value
                                                                  .text
                                                                  .toLowerCase()));

                                                  // contains(value.text
                                                  //     .toLowerCase()));
                                                }
                                              },
                                              displayStringForOption:
                                                  (Map<String, dynamic>
                                                          option) =>
                                                      option["hname"],
                                              onSelected: (value) {
                                                setState(() {
                                                  print("value----${value}");
                                                  _selectedItemcus =
                                                      value["hname"];
                                                  custmerId = value["code"];
                                                  print(
                                                      "Code .........---${custmerId}");
                                                });
                                              },
                                              fieldViewBuilder:
                                                  (BuildContext context,
                                                      fieldText,
                                                      FocusNode fieldFocusNode,
                                                      VoidCallback
                                                          onFieldSubmitted) {
                                                return TextFormField(
                                                  // validator: (val) => val!.isEmpty
                                                  //     ? 'Please select customer...'
                                                  //     : null,
                                                  controller: fieldText,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,

                                                    // hintText: 'Enter a message',
                                                    suffixIcon: IconButton(
                                                      onPressed:
                                                          fieldText.clear,
                                                      icon: Icon(Icons.clear),
                                                    ),
                                                  ),
                                                  // focusNode: _focusNode,
                                                  scrollPadding:
                                                      EdgeInsets.only(
                                                          bottom: topInsets +
                                                              size.height *
                                                                  0.27),
                                                  focusNode: fieldFocusNode,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                );
                                              },
                                              optionsMaxHeight:
                                                  size.height * 0.02,
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
                                                      width: size.width * 0.84,
                                                      height: size.height * 0.2,
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.all(
                                                            10.0),
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
                                                            onTap: () {
                                                              print(
                                                                  "optonsssssssssssss$option");
                                                              onSelected(
                                                                  option);
                                                            },
                                                            title: Text(
                                                                option["hname"]
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
                                          height: size.height * 0.01,
                                        ),
                                        ValueListenableBuilder(
                                            valueListenable: visibleValidation,
                                            builder: (BuildContext context,
                                                bool v, Widget? child) {
                                              // print("value===${visible.value}");
                                              return Visibility(
                                                visible: v,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    "Please choose Customer!!!",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              );
                                            }),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Center(
                                          child: Container(
                                            width: size.width * 0.4,
                                            height: size.height * 0.05,
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
                                                  visibleValidation.value =
                                                      false;

                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .countFromTable(
                                                    "orderBagTable",
                                                    values.ordernum[0]['os'],
                                                    custmerId.toString(),
                                                  );
                                                  Navigator.of(context).push(
                                                    PageRouteBuilder(
                                                      opaque:
                                                          false, // set to false
                                                      pageBuilder:
                                                          (_, __, ___) =>
                                                              ItemSelection(
                                                                isPlaced: widget.isPlaced,
                                                        customerId: custmerId
                                                            .toString(),
                                                        areaId: Provider.of<
                                                                    Controller>(
                                                                context,
                                                                listen: false)
                                                            .areaAutoComplete[0],
                                                        os: values.ordernum[0]
                                                            ['os'],
                                                        areaName: Provider.of<
                                                                    Controller>(
                                                                context,
                                                                listen: false)
                                                            .areaAutoComplete[1],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                ;
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
                                  //           padding:
                                  //               const EdgeInsets.only(left: 10),
                                  //           child: ElevatedButton(
                                  //             child: Text("Brosher"),
                                  //             onPressed: () {
                                  //               var platform;

                                  //               AndroidIntent intent = AndroidIntent(
                                  //                   action:
                                  //                       'android.intent.action.MAIN',
                                  //                   data: Uri.encodeFull(
                                  //                       'http://schemas.android.com/apk/res/android'),
                                  //                   package: 'com.example.g7');

                                  //               intent.launch();
                                  //             },
                                  //           )),
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
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////

}

///////////////////////////////////
Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
