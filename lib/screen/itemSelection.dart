import 'package:flutter/material.dart';

class ItemSelection extends StatefulWidget {
  // List products;
  // ItemSelection({required this.products});
  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  List<Map<String, dynamic>> products = [];
    int? selected ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
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
          // Container(
          //   height: size.height * 0.1,
          //   color: Colors.yellow,
          // ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 0.4, right: 0.4),
                    child: ListTile(
                      title: Text("helo"),
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
                            icon: Icon(Icons.add,
                            color: selected == index? Colors.green:Colors.black,),
                            onPressed: () {
                              setState(() {
                                selected=index;
                              });
                            },
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.delete),
                          //   onPressed: () {},
                          //   color: Theme.of(context).errorColor,
                          // )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
