import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customSearchTile.dart';
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/components/showMoadal.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/ORDER/8_cartList.dart';
import 'package:provider/provider.dart';

class ItemSelection extends StatefulWidget {
  // List<Map<String,dynamic>>  products;
  String customerId;
  String os;
  String areaId;
  String areaName;

  ItemSelection({
    required this.customerId,
    required this.areaId,
    required this.os,
    required this.areaName,
  });

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  String rate1 = "1";
  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();
  List<Map<String, dynamic>> products = [];
  int? selected;
  SearchTile search = SearchTile();
  DateTime now = DateTime.now();
  // CustomSnackbar snackbar = CustomSnackbar();
  List<String> s=[];
  String? date;
  bool loading = true;
  bool loading1 = false;
  CustomSnackbar snackbar = CustomSnackbar();
  bool isVisible = false;
  @override
  void dispose() {
    super.dispose();
    searchcontroll.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("areaId---${widget.customerId}");
    products = Provider.of<Controller>(context, listen: false).productName;
    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    s=date!.split(" ");
    Provider.of<Controller>(context, listen: false)
        .getProductList(widget.customerId);
    // Provider.of<Controller>(context, listen: false).getProductItems(
    //   'productDetailsTable',
    // );
    // var length =
    //     Provider.of<Controller>(context, listen: false).productName.length;
    // List.generate(length, (index) => TextEditingController());
    // List<bool> _selected = List.generate(length, (index) => false);
    // print("_selected.length-----${_selected.length}");

    // print("Product.length-----${length}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 1.0,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<Controller>(context, listen: false).searchkey = "";
              Provider.of<Controller>(context, listen: false).newList =
                  products;
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: P_Settings.wavecolor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () async {
                if (widget.customerId == null || widget.customerId.isEmpty) {
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Provider.of<Controller>(context, listen: false)
                      .getBagDetails(widget.customerId, widget.os);

                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) => CartList(
                        areaId: widget.areaId,
                        custmerId: widget.customerId,
                        os: widget.os,
                        areaname: widget.areaName,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<Controller>(context, listen: false)
                      .getBagDetails(widget.customerId, widget.os);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => CartList(
                          areaId: widget.areaId,
                          custmerId: widget.customerId,
                          os: widget.os,
                          areaname: widget.areaName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.045,
                      width: size.width * 0.2,
                      child: value.isLoading
                          ? Center(
                              child: SpinKitThreeBounce(
                              color: P_Settings.wavecolor,
                              size: 15,
                            ))
                          : Text(
                              "${value.count}",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                      decoration: BoxDecoration(
                        color: P_Settings.roundedButtonColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: size.width * 0.95,
                    height: size.height * 0.09,
                    child: TextField(
                      controller: searchcontroll,
                      onChanged: (value) {
                        Provider.of<Controller>(context, listen: false)
                            .setisVisible(true);
                        // Provider.of<Controller>(context, listen: false).isSearch=true;

                        // Provider.of<Controller>(context, listen: false)
                        //     .searchkey = value;

                        // Provider.of<Controller>(context, listen: false)
                        //     .searchProcess(widget.customerId, widget.os);
                        value = searchcontroll.text;
                      },
                      decoration: InputDecoration(
                        hintText: "Search with  Product code/Name/category",
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        suffixIcon: value.isVisible
                            ? Wrap(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.done,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getBagDetails(
                                                widget.customerId, widget.os);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .searchkey = searchcontroll.text;
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .setIssearch(true);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .searchProcess(
                                                widget.customerId, widget.os);
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getProductList(widget.customerId);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .setIssearch(false);

                                        value.setisVisible(false);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .newList
                                            .clear();

                                        searchcontroll.clear();
                                      }),
                                ],
                              )
                            : Icon(
                                Icons.search,
                                size: 20,
                              ),
                      ),
                    ),
                  ),
                ),
                value.isLoading
                    ? Container(
                        child: CircularProgressIndicator(
                            color: P_Settings.wavecolor))
                    : Expanded(
                        child: value.isSearch
                            ? value.isListLoading
                                ? Center(
                                    child: SpinKitCircle(
                                      color: P_Settings.wavecolor,
                                      size: 40,
                                    ),
                                  )
                                : value.newList.length == 0
                                    ? Container(
                                        child: Text("No data Found!!!!"),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: value.newList.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.4, right: 0.4),
                                            child: Dismissible(
                                              key: ObjectKey([index]),
                                              onDismissed: (DismissDirection
                                                  direction) async {
                                                if (direction ==
                                                    DismissDirection
                                                        .endToStart) {
                                                  print("Delete");
                                                  setState(() {
                                                    value.selected[index] =
                                                        !value.selected[index];
                                                  });
                                                  OrderAppDB.instance
                                                      .deleteFromTableCommonQuery(
                                                          "orderBagTable",
                                                          "code='${value.newList[index]["code"]}' AND customerid='${widget.customerId}'");
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .getProductList(
                                                          widget.customerId);
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .countFromTable(
                                                    "orderBagTable",
                                                    widget.os,
                                                    widget.customerId,
                                                  );
                                                }
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  '${value.newList[index]["code"]}' +
                                                      '-' +
                                                      '${value.newList[index]["item"]}',
                                                  style: TextStyle(
                                                      // color: value.selected[index]
                                                      //     ? Colors.green
                                                      //     : Colors.grey[700],
                                                      color: value
                                                              .selected[index]
                                                          ? Colors.green
                                                          : Colors.grey[700],
                                                      fontSize: 16),
                                                ),
                                                subtitle: Text(
                                                  '\u{20B9}${value.newList[index]["rate1"]}',
                                                  style: TextStyle(
                                                    color: P_Settings.ratecolor,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        width:
                                                            size.width * 0.06,
                                                        child: TextFormField(
                                                          controller:
                                                              value.qty[index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "1"),
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          if (value.selected[
                                                                  index] ==
                                                              false) {
                                                            value.selected[
                                                                    index] =
                                                                !value.selected[
                                                                    index];
                                                            selected = index;
                                                          }

                                                          if (value.qty[index]
                                                                      .text ==
                                                                  null ||
                                                              value
                                                                  .qty[index]
                                                                  .text
                                                                  .isEmpty) {
                                                            value.qty[index]
                                                                .text = "1";
                                                          }
                                                        });

                                                        int max = await OrderAppDB
                                                            .instance
                                                            .getMaxCommonQuery(
                                                                'orderBagTable',
                                                                'cartrowno',
                                                                "os='${value.ordernum[0]["os"]}' AND customerid='${widget.customerId}'");

                                                        print("max----$max");
                                                        // print("value.qty[index].text---${value.qty[index].text}");

                                                        rate1 =
                                                            value.newList[index]
                                                                ["rate1"];
                                                        var total =
                                                            int.parse(rate1) *
                                                                int.parse(value
                                                                    .qty[index]
                                                                    .text);
                                                        print(
                                                            "total rate $total");

                                                        var res = await OrderAppDB
                                                            .instance
                                                            .insertorderBagTable(
                                                                value.newList[
                                                                        index]
                                                                    ["item"],
                                                                s[0],s[1],
                                                                value.ordernum[
                                                                    0]["os"],
                                                                widget
                                                                    .customerId,
                                                                max,
                                                                value.newList[
                                                                        index]
                                                                    ["code"],
                                                                int.parse(value
                                                                    .qty[index]
                                                                    .text),
                                                                rate1,
                                                                total
                                                                    .toString(),
                                                                0);
                                                        snackbar.showSnackbar(
                                                            context,
                                                            "${value.newList[index]["code"] + value.newList[index]['item']} - Added to cart");
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .countFromTable(
                                                          "orderBagTable",
                                                          widget.os,
                                                          widget.customerId,
                                                        );

                                                        /////////////////////////
                                                        (widget.customerId.isNotEmpty ||
                                                                    widget.customerId !=
                                                                        null) &&
                                                                (products[index]["code"]
                                                                        .isNotEmpty ||
                                                                    products[index]
                                                                            [
                                                                            "code"] !=
                                                                        null)
                                                            ? Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .calculateTotal(
                                                                    value.ordernum[0]
                                                                        ['os'],
                                                                    widget
                                                                        .customerId)
                                                            : Text("No data");

                                                        // Provider.of<Controller>(context,
                                                        //         listen: false)
                                                        //     .getProductList(
                                                        //         widget.customerId);
                                                      },
                                                      color: Colors.black,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 18,
                                                        // color: Colors.redAccent,
                                                      ),
                                                      onPressed: value.newList[
                                                                      index][
                                                                  "cartrowno"] ==
                                                              null
                                                          ? value.selected[
                                                                  index]
                                                              ? () async {
                                                                  String item = value
                                                                              .newList[index]
                                                                          [
                                                                          "code"] +
                                                                      value.newList[
                                                                              index]
                                                                          [
                                                                          "item"];

                                                                  showModal.showMoadlBottomsheet(
                                                                      widget.os,
                                                                      widget
                                                                          .customerId,
                                                                      item,
                                                                      size,
                                                                      context,
                                                                      "newlist just added",
                                                                      value.newList[
                                                                              index]
                                                                          [
                                                                          "code"],
                                                                      index,
                                                                      value.qty[
                                                                          index]);
                                                                }
                                                              : null
                                                          : () async {
                                                              String item = value
                                                                              .newList[
                                                                          index]
                                                                      ["code"] +
                                                                  value.newList[
                                                                          index]
                                                                      ["item"];

                                                              showModal.showMoadlBottomsheet(
                                                                  widget.os,
                                                                  widget
                                                                      .customerId,
                                                                  item,
                                                                  size,
                                                                  context,
                                                                  "newlist already in cart",
                                                                  value.newList[
                                                                          index]
                                                                      ["code"],
                                                                  index,
                                                                  value.qty[
                                                                      index]);
                                                            },
                                                      // color: Theme.of(context).errorColor,
                                                    )
                                                  ],
                                                ),
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
                                    child: Dismissible(
                                      key: ObjectKey(index),
                                      onDismissed:
                                          (DismissDirection direction) async {
                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          print("Delete");
                                          setState(() {
                                            value.selected[index] =
                                                !value.selected[index];
                                          });
                                          OrderAppDB.instance
                                              .deleteFromTableCommonQuery(
                                                  "orderBagTable",
                                                  "code='${value.productName[index]["code"]}' AND customerid='${widget.customerId}'");
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .getProductList(
                                                  widget.customerId);
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .countFromTable(
                                            "orderBagTable",
                                            widget.os,
                                            widget.customerId,
                                          );
                                        }
                                      },
                                      child: ListTile(
                                        title: Text(
                                          '${value.productName[index]["code"]}' +
                                              '-' +
                                              '${value.productName[index]["item"]}',
                                          style: TextStyle(
                                              color: value.productName[index]
                                                          ["cartrowno"] ==
                                                      null
                                                  ? value.selected[index]
                                                      ? Colors.green
                                                      : Colors.grey[700]
                                                  : Colors.green,
                                              fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          '\u{20B9}${value.productName[index]["rate1"]}',
                                          style: TextStyle(
                                            color: P_Settings.ratecolor,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                width: size.width * 0.06,
                                                child: TextFormField(
                                                  controller: value.qty[index],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "1"),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add,
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  if (value.selected[index] ==
                                                      false) {
                                                    value.selected[index] =
                                                        !value.selected[index];
                                                    selected = index;
                                                  }

                                                  if (value.qty[index].text ==
                                                          null ||
                                                      value.qty[index].text
                                                          .isEmpty) {
                                                    value.qty[index].text = "1";
                                                  }
                                                });

                                                int max = await OrderAppDB
                                                    .instance
                                                    .getMaxCommonQuery(
                                                        'orderBagTable',
                                                        'cartrowno',
                                                        "os='${value.ordernum[0]["os"]}' AND customerid='${widget.customerId}'");

                                                print("max----$max");
                                                // print("value.qty[index].text---${value.qty[index].text}");

                                                rate1 = value.productName[index]
                                                    ["rate1"];
                                                var total = int.parse(rate1) *
                                                    int.parse(
                                                        value.qty[index].text);
                                                print("total rate $total");

                                                var res = await OrderAppDB
                                                    .instance
                                                    .insertorderBagTable(
                                                        products[index]["item"],
                                                        s[0],s[1],
                                                        value.ordernum[0]["os"],
                                                        widget.customerId,
                                                        max,
                                                        products[index]["code"],
                                                        int.parse(value
                                                            .qty[index].text),
                                                        rate1,
                                                        total.toString(),
                                                        0);

                                                snackbar.showSnackbar(context,
                                                    "${products[index]["code"] + products[index]['item']} - Added to cart");
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .countFromTable(
                                                  "orderBagTable",
                                                  widget.os,
                                                  widget.customerId,
                                                );

                                                /////////////////////////
                                                (widget.customerId.isNotEmpty ||
                                                            widget.customerId !=
                                                                null) &&
                                                        (products[index]["code"]
                                                                .isNotEmpty ||
                                                            products[index]
                                                                    ["code"] !=
                                                                null)
                                                    ? Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .calculateTotal(
                                                            value.ordernum[0]
                                                                ['os'],
                                                            widget.customerId)
                                                    : Text("No data");

                                                // Provider.of<Controller>(context,
                                                //         listen: false)
                                                //     .getProductList(
                                                //         widget.customerId);
                                              },
                                              color: Colors.black,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                size: 18,
                                                // color: Colors.redAccent,
                                              ),
                                              onPressed: value.productName[
                                                          index]["cartrowno"] ==
                                                      null
                                                  ? value.selected[index]
                                                      ? () async {
                                                          String item =
                                                              products[index]
                                                                      ["code"] +
                                                                  products[
                                                                          index]
                                                                      ["item"];
                                                          showModal
                                                              .showMoadlBottomsheet(
                                                                  widget.os,
                                                                  widget
                                                                      .customerId,
                                                                  item,
                                                                  size,
                                                                  context,
                                                                  "just added",
                                                                  products[
                                                                          index]
                                                                      ["code"],
                                                                  index,
                                                                  value.qty[
                                                                      index]);
                                                        }
                                                      : null
                                                  : () async {
                                                      String item =
                                                          products[index]
                                                                  ["code"] +
                                                              products[index]
                                                                  ["item"];
                                                      showModal
                                                          .showMoadlBottomsheet(
                                                              widget.os,
                                                              widget.customerId,
                                                              item,
                                                              size,
                                                              context,
                                                              "already in cart",
                                                              products[index]
                                                                  ["code"],
                                                              index,
                                                              value.qty[index]);
                                                    },
                                              // color: Theme.of(context).errorColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })),
              ],
            );
          },
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
}
