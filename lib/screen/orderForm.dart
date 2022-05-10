import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String selected_area = "anu";
  List<String> items_area = ["anu", "graha", "appu"];
  String selected_customer = "anu";
  List<String> items_customer = ["anu", "graha", "appu"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Card(
          //     elevation: 0,
          //     child: Ink(
          //       decoration: BoxDecoration(
          //           // borderRadius: BorderRadius.circular(20),
          //           // color: P_Settings.wavecolor
          //           ),
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.person,
          //             color: P_Settings.wavecolor,
          //           ),
          //           SizedBox(
          //             width: size.width * 0.01,
          //           ),
          //           Text(
          //             "CUSTOMER",
          //             style: TextStyle(color: P_Settings.wavecolor),
          //           ),
          //         ],

          //         // trailing: IconButton(
          //         //   icon: Icon(
          //         //     visible ? Icons.arrow_upward : Icons.arrow_downward,
          //         //     color: Colors.white,
          //         //   ),
          //         //   onPressed: () {
          //         //     setState(() {
          //         //       visible = !visible;
          //         //     });
          //         //   },
          //         // ),
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   child: Column(
          //     children: [
          //       Container(
          //         child:
          //             dropDown(selected_area, items_area, "area/route", size),
          //       ),
          //       SizedBox(height: size.height * 0.02),
          //       Container(
          //         child: dropDown(
          //             selected_customer, items_customer, "customer", size),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: size.height * 0.03,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20,right: 20),
          //   child: Container(
          //     height: size.height * 0.01,
          //     color: Colors.grey[300],
          //   ),
          // ),
          ////////////////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: size.width * 0.9,
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
                              width: size.width * 0.02,
                            ),
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                            Text("Choose Category"),
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
                                  width: size.width * 0.43,
                                ),
                                Text(
                                  "_______",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: size.width * 0.088,
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
          ),
        ],
      ),
    );
  }

  Widget dropDown(String selected, List<String> items, String type, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Container(
        // height: size.height * 0.06,
        width: size.width * 0.9,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: P_Settings.wavecolor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        child: DropdownButton<String>(
            // dropdownColor: Colors.transparent,
            isExpanded: true,
            autofocus: false,
            underline: SizedBox(),
            elevation: 0,
            value: selected,
            items: items
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      width: size.width * 0.3,
                      child: GestureDetector(
                          onTap: (() {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Page2(
                            //       item: item,
                            //     ),
                            //   ),
                            // );
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item),
                          )),
                    )))
                .toList(),
            onChanged: (item) {
              setState(() {
                if (item != null) {
                  if (type == 'area/route') {
                    selected_area = item;
                  }
                  if (type == 'customer') {
                    selected_customer = item;
                  }
                }
              });
            }),
      ),
    );
  }
}
