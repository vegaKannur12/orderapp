import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class ItemSelection extends StatefulWidget {
  // List products;
  // ItemSelection({required this.products});
  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  List<Map<String, dynamic>> products = [];
  int? selected;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: size.width * 0.95,
            height: size.height * 0.1,
            child: TextField(
              // onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 0.4, right: 0.4),
                    child: ListTile(
                      title: Text(
                        "helo",
                        style:
                            TextStyle(color: Colors.green[800], fontSize: 18),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              width: size.width * 0.09,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: "qty"),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                            color: P_Settings.addbutonColor,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                            color: Theme.of(context).errorColor,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Container(
            width: size.width * 0.95,
            height: size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10)),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 100, right: 150),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       // Add your onPressed code here!
      //     },
      //     backgroundColor: P_Settings.addbutonColor,
      //     child: Text("Count"),
      //   ),
      // ),
    );
  }
}
