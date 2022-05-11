import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String? selected;
  String? staffname;
  // List<String> items_area = ["anu", "graha", "appu"];
  // String selected_customer = "anu";
  // List<String> items_customer = ["anu", "graha", "appu"];
  bool visible = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//   }

//   getArea()async{
// String result = await OrderAppDB.instance.getArea(area);

//   }

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
      body: SafeArea(
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
                    decoration: BoxDecoration(color: P_Settings.orderFormcolor),
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
                            child:
                                dropDown(values.areaList, "area/route", size),
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
                            child: dropDown(values.areaList, "customer", size),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ORDER NO : ESOR4435"),
                                Text(
                                  '\u{20B9}${0}',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.045,
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Choose Category",
                                  style: TextStyle(color: Colors.pink),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.15,
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "EAN",
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Item Name",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Rate",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Qty",
                                        style: TextStyle(
                                            color: Colors.yellow[900],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.06,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "_______",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.45,
                                    ),
                                    Text(
                                      "_______",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.09,
                                    ),
                                    Text(
                                      "_______",
                                      style: TextStyle(
                                          color: Colors.yellow[900],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
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
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: size.height * 0.15,
                            child: Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // height: size.height * 0.06,
                                    SizedBox(width: size.width * 0.3),
                                    Text("Total items"),
                                    SizedBox(width: size.width * 0.3),
                                    Icon(Icons.shopping_cart, size: 19),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.2,
                                      height: size.height * 0.04,
                                    ),
                                    Text("Appropriate Total : "),
                                    SizedBox(width: size.width * 0.28),
                                    Text(
                                      '\u{20B9}${0}',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(height: size.height * 0.03),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Reset"),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Remark"),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                          )),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Collection"),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                          )),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Save"),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange[900],
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
    );
  }

  Widget dropDown(List<Map<String, dynamic>> items, String type, Size size) {
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
          hint: Text("Select"),
          // dropdownColor: Colors.transparent,
          isExpanded: true,
          autofocus: false,
          underline: SizedBox(),
          elevation: 0,
          // value: "INDIA",
          items: items
              .map((item) => DropdownMenuItem<String>(
                  value: item["aname"].toString(),
                  child: Container(
                    width: size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item["aname"].toString()),
                    ),
                  )))
              .toList(),

          onChanged: (item) {
            if (item != null) {}
            setState(() {
              if (item != null) {
                if (type == 'area/route') {
                  selected = item;
                }

                print("selected area..........${selected}");
              }
            });
          },
          value: selected,
        ),
      ),
    );
  }
}
