import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class CollectionPage extends StatefulWidget {
  String? type;
  CollectionPage({this.type});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Collection",
                  style: TextStyle(color: P_Settings.wavecolor, fontSize: 20,fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Series", style: TextStyle(fontSize: 15)),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("web102"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Date", style: TextStyle(fontSize: 15)),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("06-06-2022"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Transaction Mode",
                          style: TextStyle(
                               fontSize: 15)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(""),
                      ),
                      // DropdownButton<String>(
                      //   hint: Text("Select"),
                      //   isExpanded: true,
                      //   autofocus: false,
                      //   underline: SizedBox(),
                      //   elevation: 0,
                      //   items: items
                      //       .map((item) => DropdownMenuItem<String>(
                      //           value: item["aid"].toString(),
                      //           child: Container(
                      //             width: size.width * 0.5,
                      //             child: Padding(
                      //                 padding: EdgeInsets.all(8.0),
                      //                 child: Text(item["aname"].toString())),
                      //           )))
                      //       .toList(),
                      //   onChanged: (item) {
                      //     // Provider.of<Controller>(context, listen: false)
                      //     //     .customerList
                      //     //     .length = 0;
                      //     print("clicked");

                      //     if (item != null) {
                      //       setState(() {
                      //         // selected = item;
                      //         print("selected area..........${selected}");
                      //       });
                      //     }
                      //     // Provider.of<Controller>(context, listen: false).getArea(selected!);
                      //   },
                      //   // value: selected,
                      //   // disabledHint: Text(selected ?? "null"),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text("Amount", style: TextStyle(fontSize: 15)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("\u{20B9}453"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Discount", style: TextStyle(fontSize: 15)),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("\u{20B9}ryrt"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Remarks", style: TextStyle(fontSize: 15)),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 500,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 20),
                              border: OutlineInputBorder(),
                              labelText: '',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Save'),
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
