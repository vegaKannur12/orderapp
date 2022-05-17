import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  // List<TextEditingController> _controller = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Controller>(context, listen: false)
        .generateTextEditingController();
    // _controller = List.generate(length, (i) => TextEditingController());
  }
 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
                onTap: (() {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }),
        child: Consumer<Controller>(builder: (context, value, child) {
        return SafeArea(
              child: ListView.builder(
            itemCount: value.bagList.length,
            itemBuilder: (BuildContext context, int index) {
              return listItemFunction(
                  value.bagList[index]["item"],
                  value.bagList[index]["rate1"],
                  size,
                  value.controller[index],
                  index);
            },
          ));
        }),
      ),
    );
  }

  Widget listItemFunction(String itemName, double rate, Size size,
      TextEditingController _controller, int index) {
    // print("textEditing value----${_controller.text}");

    if (_controller.text.isEmpty) {
      // print("if gdrfgdfgde");
      _controller.text = "1";
    }
    Provider.of<Controller>(context,listen: false).calculateAmt(rate,_controller.text);

    return Container(
      height: size.height * 0.19,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Ink(
          // color: Colors.grey[100],
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            // leading: CircleAvatar(backgroundColor: Colors.green),
            title: Column(
              children: [
                Flexible(
                  child: Text(
                    "${itemName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: P_Settings.wavecolor),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.001,
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 40,
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                        height: size.height * 0.001,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rate",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    "Qty",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  // Spacer(),
                                  Text(
                                    "Amt",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(
                                  //   height: size.height * 0.02,
                                  // ),
                                  Text(
                                    "\u{20B9}${rate}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Container(
                                      width: size.width * 0.1,
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        keyboardType: TextInputType.number,
                                        controller: _controller,
                                      )),
                                  Text(
                                    "\u{20B9}${Provider.of<Controller>(context,
                                                listen: false).amt}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.009,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              // title: Text("Alert Dialog Box"),
                              content: Text("delete?"),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: P_Settings.wavecolor),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text("cancel"),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: P_Settings.wavecolor),
                                      onPressed: () {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .deleteListWidget(index);
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text("ok"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: P_Settings.extracolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // trailing: IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.delete),
            // ),
          ),
        ),
      ),
    );
  }

}
