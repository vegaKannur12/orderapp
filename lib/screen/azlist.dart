// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:orderapp/components/commoncolor.dart';
// import 'package:orderapp/components/customSearchTile.dart';
// import 'package:orderapp/db_helper.dart';
// import 'package:orderapp/screen/cartList.dart';
// import 'package:provider/provider.dart';
// import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
// import '../controller/controller.dart';
// import '../components/customSnackbar.dart';

// class AZList extends StatefulWidget {
//   String customerId;
//   String os;
//   String areaId;
//   AZList({required this.customerId, required this.areaId, required this.os});

//   @override
//   State<AZList> createState() => _AZListState();
// }

// class _AZListState extends State<AZList> {
//   List<String> strList = ["anu","amal","babi","chahaaa"];
//   String rate1 = "1";
//   int count = 1;
//   List<Map<String, dynamic>> products = [];
//   int? selected;
//   SearchTile search = SearchTile();
//   DateTime now = DateTime.now();
//   CustomSnackbar snackbar = CustomSnackbar();
//   String? date;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     products = Provider.of<Controller>(context, listen: false).productName;
//     Provider.of<Controller>(context, listen: false).getOrderno();
//     date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//     Provider.of<Controller>(context, listen: false).getProductItems(
//       'productDetailsTable',
//     );
//     var length =
//         Provider.of<Controller>(context, listen: false).productName.length;
//     List.generate(length, (index) => TextEditingController());
//     // products = Provider.of<Controller>(context, listen: false).productName;
//   }

//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.indigo,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.shopping_cart,
//               color: Colors.white,
//               size: 25,
//             ),
//             onPressed: () async {
//               if (widget.customerId == null || widget.customerId.isEmpty) {
//               } else {
//                 Provider.of<Controller>(context, listen: false)
//                     .getBagDetails(widget.customerId, widget.os);

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CartList(
//                             areaId: widget.areaId,
//                             custmerId: widget.customerId,
//                             os: widget.os,
//                           )),
//                 );
//               }
//             },
//           )
//         ],
//       ),
//       body: Consumer<Controller>(builder: (context, value, child) {
//         return Column(
//           children: [
//             Container(
//                 alignment: Alignment.center,
//                 height: size.height * 0.045,
//                 width: size.width * 0.2,
//                 child: Text(
//                     "${Provider.of<Controller>(context, listen: false).count}"),
//                 decoration: BoxDecoration(
//                   color: P_Settings.roundedButtonColor,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(50),
//                     bottomRight: Radius.circular(50),
//                   ),
//                 )),
//             Container(
//               width: size.width * 0.95,
//               height: size.height * 0.09,
//               child: TextField(
//                 onChanged: (value) =>
//                     Provider.of<Controller>(context, listen: false)
//                         .searchProcess(value),
//                 decoration: const InputDecoration(
//                     labelText: 'Search', suffixIcon: Icon(Icons.search)),
//               ),
//             ),
//             value.isLoading
//                 ? Container(
//                     child:
//                         CircularProgressIndicator(color: P_Settings.wavecolor))
//                 : Expanded(
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: value.productName.length,
//                         itemBuilder: (BuildContext context, index) {
//                           return AlphabetListScrollView(
//                             strList: value.productName[index]["item"],
//                             keyboardUsage: true,
//                             headerWidgetList: [],
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 0.4, right: 0.4),
//                                 child: ListTile(
//                                   title: Text(
//                                     '${value.productName[index]["code"]}' +
//                                         '-' +
//                                         '${value.productName[index]["item"]}',
//                                     style: TextStyle(
//                                         color: Colors.green[800], fontSize: 18),
//                                   ),
//                                   trailing: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Container(
//                                           width: size.width * 0.09,
//                                           child: TextFormField(
//                                             controller: value.qty[index],
//                                             keyboardType: TextInputType.number,
//                                             decoration: InputDecoration(
//                                                 border: InputBorder.none,
//                                                 hintText: "qty"),
//                                           )),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       IconButton(
//                                         icon: Icon(Icons.add),
//                                         onPressed: () async {
//                                           setState(() {
//                                             selected = index;
//                                             if (value.qty[index].text == null ||
//                                                 value.qty[index].text.isEmpty) {
//                                               value.qty[index].text = "1";
//                                             }
//                                           });

//                                           int max = await OrderAppDB.instance
//                                               .getMaxCommonQuery(
//                                                   'orderBagTable',
//                                                   'cartrowno',
//                                                   "os='${value.ordernum[0]["os"]}' AND customerid='${widget.customerId}'");

//                                           print("max----$max");
//                                           // print("value.qty[index].text---${value.qty[index].text}");

//                                           rate1 =
//                                               value.productName[index]["rate1"];
//                                           var total = int.parse(rate1) *
//                                               int.parse(value.qty[index].text);
//                                           print("total rate $total");

//                                           // var res = widget.customerId ==
//                                           //             null ||
//                                           //         widget.customerId.isEmpty
//                                           //     ? null
//                                           //     // : await OrderAppDB.instance
//                                           //     //     .insertCommonQuery(
//                                           //     //         'orderBagTable',
//                                           //     //         'itemName, cartdatetime, os, customerid, cartrowno, code, qty, rate, totalamount, cstatus',
//                                           //     //         "'$itemName','$date!','1','$custmerId!',$max,'$productCode!',2,'$rate1','46',0");
//                                           //     :
//                                           var res = await OrderAppDB.instance
//                                               .insertorderBagTable(
//                                                   products[index]["item"],
//                                                   date!,
//                                                   value.ordernum[0]["os"],
//                                                   widget.customerId,
//                                                   max,
//                                                   products[index]["code"],
//                                                   int.parse(
//                                                       value.qty[index].text),
//                                                   rate1,
//                                                   total.toString(),
//                                                   0);
//                                           // print("result........... $res");
//                                           //  Provider.of<Controller>(context,
//                                           //           listen: false).countFromTable("orderBagTable");
//                                           widget.customerId == null ||
//                                                   widget.customerId.isEmpty ||
//                                                   products[index]["code"] ==
//                                                       null ||
//                                                   products[index]["code"]!
//                                                       .isEmpty
//                                               ? Text("Select customer")
//                                               : Provider.of<Controller>(context,
//                                                       listen: false)
//                                                   .countFromTable(
//                                                   "orderBagTable",
//                                                   widget.os,
//                                                   widget.customerId,
//                                                 );

//                                           /////////////////////////

//                                           (widget.customerId.isNotEmpty ||
//                                                       widget.customerId !=
//                                                           null) &&
//                                                   (products[index]["code"]
//                                                           .isNotEmpty ||
//                                                       products[index]["code"] !=
//                                                           null)
//                                               ? Provider.of<Controller>(context,
//                                                       listen: false)
//                                                   .calculateTotal(
//                                                       value.ordernum[0]['os'],
//                                                       widget.customerId)
//                                               // snackbar.showSnackbar(
//                                               //     context, "Added to cart")
//                                               : Text("No data");
//                                         },
//                                         color: selected == index
//                                             ? P_Settings.addbutonColor
//                                             : Colors.black,
//                                       ),
//                                       IconButton(
//                                         icon: Icon(Icons.delete),
//                                         onPressed: () {},
//                                         color: Theme.of(context).errorColor,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                             indexedHeight: (index) => 80,
//                           );
//                         }),
//                   ),
//           ],
//         );
//       }),
//     );
//   }
// }
