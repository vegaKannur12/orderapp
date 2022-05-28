import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class ShowModal {
  showMoadlBottomsheet(
      String os,
      String customerId,
      String item,
      Size size,
      BuildContext context,
      String type,
      String code,
      int selected_index,
      TextEditingController qty_index) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer<Controller>(
            builder: (context, value, child) {
              return Container(
                height: size.width * 0.3,
                // color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do you want to delete ",style: TextStyle(fontSize: 15)),
                          Text("${item}",style: TextStyle(color: Colors.red,fontSize: 15),),
                          Text(" from cart ?",style: TextStyle(fontSize: 15))
                        ],
                      ),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text('delete'),
                              onPressed: () async {
                                if (type == "already in cart") {
                                  if (value.selected[selected_index] == false) {
                                    value.selected[selected_index] = true;
                                  }

                                  qty_index.clear();
                                  await OrderAppDB.instance
                                      .deleteFromTableCommonQuery(
                                          "orderBagTable",
                                          "code='${code}' AND customerid='${customerId}'");

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .countFromTable(
                                          "orderBagTable", os, customerId);
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getProductList(customerId);
                                  Navigator.of(context).pop();
                                }

                                if (type == "just added") {
                                  if (value.selected[selected_index]) {
                                    value.selected[selected_index] =
                                        !value.selected[selected_index];
                                  }

                                  qty_index.clear();
                                  await OrderAppDB.instance
                                      .deleteFromTableCommonQuery(
                                          "orderBagTable",
                                          "code='${code}' AND customerid='${customerId}'");

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .countFromTable(
                                    "orderBagTable",
                                    os,
                                    customerId,
                                  );
                                  Navigator.of(context).pop();
                                }
                                if (type == "newlist just added") {
                                  if (value.selected[selected_index]) {
                                    value.selected[selected_index] =
                                        !value.selected[selected_index];
                                  }

                                  value.qty[selected_index].clear();
                                  await OrderAppDB.instance
                                      .deleteFromTableCommonQuery(
                                          "orderBagTable",
                                          "code='${value.newList[selected_index]["code"]}' AND customerid='${customerId}'");

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .countFromTable(
                                    "orderBagTable",
                                    os,
                                    customerId,
                                  );
                                  Navigator.of(context).pop();
                                }
                                if (type == "newlist already in cart") {
                                  if (value.selected[selected_index]) {
                                    value.selected[selected_index] =
                                        !value.selected[selected_index];
                                  }

                                  value.qty[selected_index].clear();
                                  await OrderAppDB.instance
                                      .deleteFromTableCommonQuery(
                                          "orderBagTable",
                                          "code='${value.newList[selected_index]["code"]}' AND customerid='${customerId}'");

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .countFromTable(
                                    "orderBagTable",
                                    os,
                                    customerId,
                                  );
                                  // Provider.of<Controller>(context,
                                  //       listen: false)
                                  //   .searchProcess();
                                  Navigator.of(context).pop();
                                }
                              }),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          ElevatedButton(
                            child: const Text('cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
