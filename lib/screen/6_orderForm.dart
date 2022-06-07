import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/6.1_remarks.dart';
import 'package:orderapp/screen/6_collection.dart';
import 'package:orderapp/screen/7_itemSelection.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/customPopup.dart';
import '../components/customSnackbar.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderForm extends StatefulWidget {
  String areaname;

  OrderForm(
    this.areaname,
  );

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> with TickerProviderStateMixin {
  TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingValue textvalue = TextEditingValue();
  final _formKey = GlobalKey<FormState>();
  bool customerFlag = true;
  bool isLoading = false;
  String? areaName;
  String? customerName;
  String? _selectedItemarea;
  bool customerValidation = false;
  String? area;
  CustomPopup popup = CustomPopup();
  String? _selectedItemcus;
  String? _selectedItem;
  CustomSnackbar snackbar = CustomSnackbar();
  List<Map<String, dynamic>>? newList = [];
  ValueNotifier<int> dtatableRow = ValueNotifier(0);
  // ValueNotifier<bool> visibleValidation = ValueNotifier(false);

  TextEditingController eanQtyCon = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController eanTextCon = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();

  // final formGlobalKey = GlobalKey<FormState>();
  List? splitted;
  TextEditingController fieldText = TextEditingController();
  List? splitted1;
  List<DataRow> dataRows = [];
  String? selected;
  String? productCode;
  String? selectedCus;
  String? common;
  String? custmerId;
  String? sid;
  String? os;
  bool areavisible = false;
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("hellooo");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    Provider.of<Controller>(context, listen: false).custmerSelection = "";

    sharedPref();
  }

  sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    os = prefs.getString("os");

    print("sid--os-${sid}--$os");
    Provider.of<Controller>(context, listen: false).getArea(sid!);
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
                  key: _formKey,
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
                                  Text("SALES ORDER",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: P_Settings.bodycolor,
                                          fontWeight: FontWeight.bold)
                                      // ),
                                      ),
                                ]),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
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
                                      // height: size.height * 0.06,
                                      child: Autocomplete<Map<String, dynamic>>(
                                        initialValue: TextEditingValue(
                                            text: widget.areaname),
                                        optionsBuilder:
                                            (TextEditingValue value) {
                                          if (value.text.isEmpty) {
                                            return [];
                                          } else {
                                            // print(
                                            //     "TextEditingValue---${value.text}");

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
                                            _selectedItemarea = value["aname"];
                                            areaName = value["aname"];
                                            print("areaName...$areaName");
                                            _selectedAreaId = value["aid"];
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .areaAutoComplete = [
                                              _selectedAreaId!,
                                              _selectedItemarea!,
                                            ];
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .getCustomer(_selectedAreaId!);
                                          });
                                        },
                                        fieldViewBuilder: (BuildContext context,
                                            areaController,
                                            FocusNode fieldFocusNode,
                                            VoidCallback onFieldSubmitted) {
                                          return Container(
                                            height: size.height * 0.08,
                                            child: TextFormField(
                                              maxLines: 1,
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
                                                // hintText: 'Name',
                                                helperText: ' ', // th
                                                suffixIcon: IconButton(
                                                  onPressed: fieldText.clear,
                                                  icon: Icon(Icons.clear),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please choose area!!';
                                                }
                                                return null;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              autofocus: true,
                                              controller: areaController,
                                              focusNode: fieldFocusNode,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
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
                                                height: size.height * 0.2,
                                                width: size.width * 0.84,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.all(10.0),
                                                  itemCount: options.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final Map<String, dynamic>
                                                        option = options
                                                            .elementAt(index);
                                                    print(
                                                        "option----${option}");
                                                    return ListTile(
                                                      onTap: () {
                                                        onSelected(option);
                                                        Provider.of<Controller>(
                                                                    context,
                                                                    listen: false)
                                                                .areaSelection =
                                                            option["aid"];
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
                                          // height: size.height * 0.06,
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
                                                (Map<String, dynamic> option) =>
                                                    option["hname"],
                                            onSelected: (value) {
                                              setState(() {
                                                print("value----${value}");
                                                _selectedItemcus =
                                                    value["hname"];
                                                customerName = value["hname"];
                                                custmerId = value["code"];
                                                print(
                                                    "Code .........---${custmerId}");
                                              });
                                            },
                                            fieldViewBuilder: (BuildContext
                                                    context,
                                                fieldText,
                                                FocusNode fieldFocusNode,
                                                VoidCallback onFieldSubmitted) {
                                              return Container(
                                                height: size.height * 0.08,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      gapPadding: 1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 3,
                                                      ),
                                                    ),
                                                    // hintText: 'Name',
                                                    helperText: ' ', // th
                                                    suffixIcon: IconButton(
                                                      onPressed:
                                                          fieldText.clear,
                                                      icon: Icon(Icons.clear),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please choose Customer!!!';
                                                    }
                                                    return null;
                                                  },
                                                  controller: fieldText,
                                                  focusNode: fieldFocusNode,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
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
                                                            onSelected(option);

                                                            Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .custmerSelection =
                                                                option["code"];
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
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: size.width * 0.26,
                                              height: size.height * 0.05,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                   FocusScopeNode currentFocus =
                                                      FocusScope.of(context);

                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }

                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                  Navigator.of(context).push(
                                                    PageRouteBuilder(
                                                      opaque:
                                                          false, // set to false
                                                      pageBuilder:
                                                          (_, __, ___) =>
                                                              RemarkPage(),
                                                    ),
                                                  );
                                                }},
                                                label: Text(
                                                  'Remarks',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                icon: Icon(
                                                  Icons.comment,
                                                  size: 14,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.lightBlue,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * 0.27,
                                              height: size.height * 0.05,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);

                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }

                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        opaque:
                                                            false, // set to false
                                                        pageBuilder:
                                                            (_, __, ___) =>
                                                                CollectionPage(
                                                          os: os,
                                                          sid: sid,
                                                          cuid: Provider.of<
                                                                      Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .custmerSelection,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                label: Text(
                                                  'Collection',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                icon: Icon(
                                                  Icons.comment,
                                                  size: 15,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 194, 85, 93),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: size.width * 0.27,
                                              height: size.height * 0.05,
                                              child: ElevatedButton.icon(
                                                icon: Icon(
                                                  Icons.library_add_check,
                                                  color: Colors.white,
                                                  size: 15.0,
                                                ),
                                                label: Text(
                                                  "Add Items",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                onPressed: () async {
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);

                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }

                                                  if (_formKey.currentState!
                                                      .validate()) {
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
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: P_Settings.wavecolor,
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
