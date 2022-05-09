import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class OrderForm extends StatefulWidget {
  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  String selected_area = "anu";
  List<String> items_area = ["anu", "graha", "appu"];
  String selected_customer = "anu";
  List<String> items_customer = ["anu", "graha", "appu"];
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(  
          child: Container(
            height: size.height*0.25,
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: P_Settings.wavecolor),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            "CUSTOMER",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     visible ? Icons.arrow_upward : Icons.arrow_downward,
                      //     color: Colors.white,
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
                Container(
                  child: Column(
                    children: [
                      Container(
                        child:
                            dropDown(selected_area, items_area, "area/route", size),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        child: dropDown(
                            selected_customer, items_customer, "customer", size),
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

  Widget dropDown(String selected, List<String> items, String type, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0,right: 16),
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
