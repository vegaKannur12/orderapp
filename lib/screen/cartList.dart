import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  List<Map<String, dynamic>> listWidget;
  CartList({required this.listWidget});
  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.builder(
            itemCount: widget.listWidget.length,
            itemBuilder: (BuildContext context, int index) {
              return listItemFunction(widget.listWidget[index]["item"],
                  widget.listWidget[index]["rate1"], size);
            }),
      ),
    );
  }

  Widget listItemFunction(String itemName, double rate, Size size) {
    return Container(
      // decoration: BoxDecoration(
      //     // shape: BoxShape.circle,
      //     borderRadius: BorderRadius.all(Radius.circular(10))),
      height: size.height * 0.14,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.03,
                    child: Row(
                      children: [
                        Text(
                          "Item Name  ",
                        
                        ),Text(":"),
                        Text("${itemName}",style: TextStyle(fontWeight: FontWeight.bold),),
                        Spacer(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.05,
                    child: Row(
                      children: [
                        Text(
                          "Rate  ", 
                        
                        ),Text(":"),
                        Text("${rate}",style: TextStyle(fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text("qty")
                      ],
                    ),
                  ),
                  // Row(
                  //   children: [Text("Order No")],
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
