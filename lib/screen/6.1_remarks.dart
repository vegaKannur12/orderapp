import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customPopup.dart';
import 'package:orderapp/components/customToast.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

class RemarkPage extends StatefulWidget {
  String cus_id;
  String ser;
  String sid;
  RemarkPage({required this.cus_id, required this.ser, required this.sid});

  @override
  State<RemarkPage> createState() => _RemarkPageState();
}

class _RemarkPageState extends State<RemarkPage> {
  TextEditingController remarkController = TextEditingController();
  TextEditingController remarkController1 = TextEditingController();
  CustomToast tost = CustomToast();
  DateTime now = DateTime.now();
  String? date;
  CustomPopup popup = CustomPopup();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('yyyy-MM-dd').format(now);
    Provider.of<Controller>(context, listen: false)
        .fetchremarkFromTable(widget.cus_id);
    print("date...${date}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await OrderAppDB.instance
                    .deleteFromTableCommonQuery("remarksTable", "");
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Remarks",
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
                        Text("Date"),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            width: size.width * 0.9,
                            color: P_Settings.collection,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                date.toString(),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
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
                              controller: remarkController,
                              minLines:
                                  3, // any number you need (It works as the rows for the textarea)
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: remarkController.clear,
                                    icon: Icon(
                                      Icons.clear,
                                      size: 18,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 20),
                                  border: OutlineInputBorder(),
                                  labelText: '',
                                  hintText: 'Type here...'),
                              onChanged: (value) {
                                value = remarkController.text;
                                print("object......${remarkController.text}");
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Container(
                            width: size.width * 0.9,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // primary: P_Settings.roundedButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (remarkController.text != null ||
                                    remarkController.text.isNotEmpty) {
                                  int max = await OrderAppDB.instance
                                      .getMaxCommonQuery(
                                          'remarksTable',
                                          'rem_row_num',
                                          "rem_cusid='${widget.cus_id}'");
                                  print("jhjdfmax---$max");

                                  await OrderAppDB.instance.insertremarkTable(
                                      date!,
                                      widget.cus_id,
                                      widget.ser,
                                      remarkController.text,
                                      widget.sid,
                                      max,
                                      0,
                                      0);
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .fetchremarkFromTable(widget.cus_id);
                                  remarkController.clear();
                                  tost.toast("success");
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<Controller>(
                    builder: (context, value, child) {
                      return Container(
                        // color: P_Settings.collection,
                        height: size.height * 0.7,
                        child: ListView.builder(
                          itemCount: value.remarkList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                key: ObjectKey([index]),
                                onDismissed:
                                    (DismissDirection direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    print("Delete");
                                    setState(() {
                                      OrderAppDB.instance
                                          .deleteFromTableCommonQuery(
                                              "remarksTable",
                                              "rem_row_num='${value.remarkList[index]["rem_row_num"]}'");
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .fetchremarkFromTable(widget.cus_id);
                                    });
                                  }
                                },
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
                                    value.remarkList[index]['rem_text']
                                        .toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      remarkController1.clear();
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          content: TextField(
                                            controller: remarkController1,
                                            minLines:
                                                3, // any number you need (It works as the rows for the textarea)
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed:
                                                    remarkController1.clear,
                                                icon: Icon(
                                                  Icons.clear,
                                                  size: 18,
                                                ),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 40,
                                                      horizontal: 20),
                                              border: OutlineInputBorder(),
                                              // hintText: value.remarkList[index]
                                              //         ['rem_text']
                                              //     .toString(),
                                            ),
                                            onChanged: (value) {
                                              value = remarkController1.text;
                                            },
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: P_Settings
                                                              .wavecolor),
                                                  onPressed: () async {
                                                    await OrderAppDB.instance
                                                        .upadteCommonQuery(
                                                            "remarksTable",
                                                            "rem_text='${remarkController1.text}'",
                                                            "rem_row_num='${value.remarkList[index]["rem_row_num"]}'");
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .fetchremarkFromTable(
                                                            widget.cus_id);
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text("Edit"),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.01,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
