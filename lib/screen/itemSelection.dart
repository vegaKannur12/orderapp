import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customSearchTile.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

class ItemSelection extends StatefulWidget {
  // List<Map<String,dynamic>>  products;
  // ItemSelection({required this.products});
  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  List<Map<String, dynamic>> products = [];
  int? selected;
  SearchTile search = SearchTile();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = Provider.of<Controller>(context, listen: false).productName;
  }

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
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                width: size.width * 0.95,
                height: size.height * 0.1,
                child: TextField(
                  onChanged: (value) => Provider.of<Controller>(context, listen: false).searchProcess( value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 0.4, right: 0.4),
                        child: ListTile(
                          title: Text(
                            '${products[index]["code"]}' +
                                '-' +
                                '${products[index]["item"]}',
                            style: TextStyle(
                                color: Colors.green[800], fontSize: 18),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  width: size.width * 0.09,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "qty"),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    selected = index;
                                  });
                                },
                                color: selected == index
                                    ? P_Settings.addbutonColor
                                    : Colors.black,
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
            ],
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 100, right: 150),
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: P_Settings.addbutonColor,
          child: Text("Count"),
        ),
      ),
    );
  }
}
