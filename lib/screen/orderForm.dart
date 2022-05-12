import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String? _selectedItem;
  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];
  TextEditingController ordercode = TextEditingController();
  TextEditingController orderrate = TextEditingController();
  TextEditingController ordername = TextEditingController();
  TextEditingController orderqty = TextEditingController();
  List<DataRow> dataRows = [];
  String? selected;
  String? selectedCus;
  String? common;

  String? staffname;
  bool visible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor:P_Settings.detailscolor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<Controller>(builder: (context, values, child) {
              print("value.areaList-----${values.areaList}");

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
                        trailing: IconButton(
                          icon: Icon(
                            visible ? Icons.arrow_upward : Icons.arrow_downward,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visible,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        height: size.height * 0.19,
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
                            Container(
                              child: dropDown1(
                                  values.areaList, "area/route", size),
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
                            Container(
                              child: dropDown2(
                                  values.customerList, "customer", size),
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
                                    "ESOR4435",
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
                            height: size.height * 0.05,
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Choose Category",
                                    style: TextStyle(
                                        color: P_Settings.chooseCategory),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.4,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        dataRows.add(DataRow(cells: [
                                          DataCell(
                                            TextField(
                                              readOnly: true,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                ordercode.text;
                                              },
                                            ),
                                          ),
                                          DataCell(
                                            Autocomplete<String>(
                                              optionsBuilder:
                                                  (TextEditingValue value) {
                                                // When the field is empty
                                                if (value.text.isEmpty) {
                                                  return [];
                                                }

                                                // The logic to find out which ones should appear
                                                return _suggestions.where(
                                                    (suggestion) => suggestion
                                                        .toLowerCase()
                                                        .contains(value.text
                                                            .toLowerCase()));
                                              },
                                              onSelected: (value) {
                                                setState(() {
                                                  _selectedItem = value;
                                                });
                                              },
                                            ),
                                          ),
                                          DataCell(
                                            TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                orderqty.text;
                                              },
                                            ),
                                          ),
                                          DataCell(
                                            TextField(
                                              readOnly: true,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                orderrate.text;
                                              },
                                            ),
                                          ),
                                        ]));
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: P_Settings.roundedButtonColor,
                                      // shape: CircleBorder(),
                                    ),
                                    child: Icon(Icons.add,
                                        size: 20, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.25,
                            width: size.width * 0.9,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: FittedBox(
                                child: DataTable(
                                    headingRowHeight: 30,
                                    decoration: BoxDecoration(
                                        color: P_Settings.tableheadingColor),
                                    dataRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'EAN',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.dataTable,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Item Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.dataTable,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'QTY',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.dataTable,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Rate',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.dataTable,
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: dataRows
                                    // rows: const <DataRow>[
                                    //   DataRow(
                                    //     cells: <DataCell>[
                                    //       DataCell(
                                    //         Text('1'),
                                    //       ),
                                    //       DataCell(
                                    //         TextField(
                                    //           obscureText: true,
                                    //           decoration: InputDecoration(
                                    //             border: OutlineInputBorder(),
                                    //             labelText: '',
                                    //             hintText: 'Item name',
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       DataCell(
                                    //         TextField(
                                    //           obscureText: true,
                                    //           decoration: InputDecoration(
                                    //             border: OutlineInputBorder(),
                                    //             labelText: '',
                                    //             hintText: 'QTY',
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       DataCell(
                                    //         Text('5*'),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ],
                                    ),
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
                                      Flexible(
                                        child: TextField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              // border: UnderlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //       color: Color.fromARGB(
                                              //           255, 11, 177, 38)),
                                              // ),
                                              ),
                                          onChanged: (value) {},
                                        ),
                                      ),
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
                                      Text("Appropriate Total : "),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          readOnly: true,
                                          obscureText: true,
                                          // decoration: InputDecoration(
                                          //   // border: UnderlineInputBorder(
                                          //   //   borderSide: BorderSide(
                                          //   //       color: Color.fromARGB(
                                          //   //           255, 11, 177, 38)),
                                          //   // ),
                                          // ),
                                          onChanged: (value) {},
                                        ),
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
                                        // ElevatedButton(
                                        //   onPressed: () {},
                                        //   child: Text("Reset"),
                                        // ),
                                        // ElevatedButton(
                                        //     onPressed: () {},
                                        //     child: Text("Remark"),
                                        //     style: ElevatedButton.styleFrom(
                                        //       primary: Colors.red,
                                        //     )),
                                        // ElevatedButton(
                                        //     onPressed: () {},
                                        //     child: Text("Collection"),
                                        //     style: ElevatedButton.styleFrom(
                                        //       primary: Colors.green,
                                        //     )),
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
      child: Container(
        height: size.height * 0.045,
        width: size.width * 0.9,
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
          // dropdownColor: Colors.transparent,
          isExpanded: true,
          autofocus: false,
          underline: SizedBox(),
          elevation: 0,
          // value: "INDIA",
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
            print("clicked");

            if (item != null) {}
            setState(() {
              if (item != null) {
                selected = item;
                print("selected area..........${selected}");
              }
            });
            //  Provider.of<Controller>(context, listen: false).customerList.clear();

            Provider.of<Controller>(context, listen: false)
                .getCustomer(selected!, context);
          },
          value: selected,
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////
  Widget dropDown2(List<Map<String, dynamic>> cust, String type, Size size) {
    // print("value.custmer-----${items}");
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Container(
        height: size.height * 0.045,
        width: size.width * 0.9,
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
          disabledHint: cust.isEmpty || cust == null ? Text("Select") : null,
          hint: Text("Select"),
          // dropdownColor: Colors.transparent,
          isExpanded: true,
          autofocus: false,
          underline: SizedBox(),
          elevation: 0,
          // value: "INDIA",
          items: cust
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
            if (cust != null && cust.isNotEmpty) {}
            setState(() {
              if (cust != null) {
                selectedCus = cust;
                print("selected cus..........${selected}");
              }
            });
            // Provider.of<Controller>(context, listen: false).getCustomer(selected!);
          },
          value: selectedCus,
        ),
      ),
    );
  }
}
