import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    Provider.of<Controller>(context, listen: false).getProductItems(
      'productDetailsTable',
    );
    // products = Provider.of<Controller>(context, listen: false).productName;
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
                height: size.height * 0.09,
                child: TextField(
                  onChanged: (value) =>
                      Provider.of<Controller>(context, listen: false)
                          .searchProcess(value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
              ),
              value.isLoading
                  ? Container(
                      height: size.height * 0.6,
                      child: CircularProgressIndicator(
                          color: P_Settings.wavecolor))
                  : Expanded(
                      child: value.isSearch
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.newList.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.4, right: 0.4),
                                  child: ListTile(
                                    title: Text(
                                      '${value.newList[index]["code"]}' +
                                          '-' +
                                          '${value.newList[index]["item"]}',
                                      style: TextStyle(
                                          color: Colors.green[800],
                                          fontSize: 18),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: size.width * 0.09,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
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
                              })
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.productName.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.4, right: 0.4),
                                  child: ListTile(
                                    title: Text(
                                      '${value.productName[index]["code"]}' +
                                          '-' +
                                          '${value.productName[index]["item"]}',
                                      style: TextStyle(
                                          color: Colors.green[800],
                                          fontSize: 18),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: size.width * 0.09,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
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
          );
        },
      ),
    );
  }
}
