import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customToast.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionPage extends StatefulWidget {
  String? os;
  String? sid;
  String? cuid;

  CollectionPage({this.os, this.sid, this.cuid});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  ValueNotifier<bool> visible = ValueNotifier(false);
  DateTime date = DateTime.now();
  String? formattedDate;
  bool amtVal = true;
  bool dscVal = true;
  // List<String> items = ["Cash receipt", "Google pay"];
  String? selected;
  String? os;

  TextEditingController amtController = TextEditingController();
  TextEditingController dscController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CustomToast tst = CustomToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // shared();
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    print("cuid----${widget.cuid}");
    Provider.of<Controller>(context, listen: false)
        .fetchrcollectionFromTable(widget.cuid!, formattedDate!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          // reverse: true,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Consumer<Controller>(
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Collection",
                          style: TextStyle(
                              color: P_Settings.wavecolor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
                              Text("Series",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.os.toString()),
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
                                    child: Text(
                                      formattedDate.toString(),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text("Transaction Mode",
                                  style: TextStyle(fontSize: 15)),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                color: Colors.grey[200],
                                height: size.height * 0.04,
                                child: DropdownButton<String>(
                                  value: selected,
                                  hint: Text("Select"),
                                  isExpanded: true,
                                  autofocus: false,
                                  underline: SizedBox(),
                                  elevation: 0,
                                  items: value.walletList
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item["waid"].toString(),
                                          child: Container(
                                            width: size.width * 0.5,
                                            child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                    item["wname"].toString())),
                                          )))
                                      .toList(),
                                  onChanged: (item) {
                                    print("clicked");

                                    if (item != null) {
                                      setState(() {
                                        selected = item;
                                      });
                                      print("se;ected---$item");
                                    }
                                  },

                                  // disabledHint: Text(selected ?? "null"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text("Amount",
                                    style: TextStyle(fontSize: 15)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: amtController,
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        )),
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
                                  height: size.height * 0.04,
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: dscController,
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        )),
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
                                  width: size.width * 0.9,
                                  child: TextField(
                                    controller: noteController,
                                    minLines:
                                        2, // any number you need (It works as the rows for the textarea)
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 30, horizontal: 20),
                                      border: OutlineInputBorder(),
                                      labelText: '',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Center(
                                child: Container(
                                  width: size.width * 0.3,
                                  height: size.height * 0.05,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      print(
                                          "hjfhdfhn---${amtController.text}---${dscController.text}");
                                      //  double sum=double.parse( amtController.text)+double.parse( dscController.text);

                                      if (amtController.text.isEmpty &&
                                              dscController.text.isEmpty ||
                                          selected == null) {
                                        visible.value = true;
                                      } else {
                                        visible.value = false;

                                        await OrderAppDB.instance
                                            .insertCollectionTable(
                                                formattedDate!,
                                                widget.cuid!,
                                                widget.os!,
                                                selected!,
                                                double.parse(
                                                    amtController.text),
                                                dscController.text,
                                                noteController.text,
                                                widget.sid!,
                                                0,
                                                0);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .collectionList
                                            .clear();
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .fetchrcollectionFromTable(
                                                widget.cuid!, formattedDate!);
                                        amtController.clear();
                                        dscController.clear();
                                        noteController.clear();

                                        // await OrderAppDB.instance.upadteCommonQuery('accountHeadsTable',"ba='${item["order_id"]}'","os='${os}' AND customerid='${customerId}'" );
                                        tst.toast("Saved");
                                      }

                                      //  }
                                    },
                                    child: Text('Save'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Center(
                                child: ValueListenableBuilder(
                                    valueListenable: visible,
                                    builder: (BuildContext context, bool v,
                                        Widget? child) {
                                      print("value===${visible.value}");
                                      return Visibility(
                                        visible: v,
                                        child: Text(
                                          "Please fill corresponding fields!!!",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Consumer<Controller>(
                              builder: (context, value, child) {
                                return Container(
                                  // color: P_Settings.collection,
                                  height: size.height * 0.7,
                                  child: ListView.builder(
                                    itemCount: value.collectionList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Icon(
                                              Icons.reviews,
                                              size: 16,
                                            ),
                                            backgroundColor:
                                                P_Settings.roundedButtonColor,
                                          ),
                                          title: Text(
                                            value.collectionList[index]
                                                ['rec_date'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          subtitle: Text(
                                              "\u{20B9}${value.collectionList[index]['rec_amount'].toString()}"),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
