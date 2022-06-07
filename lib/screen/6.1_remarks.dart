import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

class RemarkPage extends StatefulWidget {
  String Cus_id;
  String ser;
  String sid;
  RemarkPage({required this.Cus_id, required this.ser, required this.sid});

  @override
  State<RemarkPage> createState() => _RemarkPageState();
}

class _RemarkPageState extends State<RemarkPage> {
  TextEditingController remarkController = TextEditingController();
  DateTime now = DateTime.now();
  String? date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('yyyy-MM-dd').format(now);
    Provider.of<Controller>(context, listen: false)
        .fetchremarkFromTable(widget.Cus_id);
    print("date...${date}");
  }

  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   print("hellooo");
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                                  icon: Icon(Icons.clear,size: 18,),
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
                              var remarkdata = await OrderAppDB.instance
                                  .insertremarkTable(
                                      date!,
                                      widget.Cus_id,
                                      widget.ser,
                                      remarkController.text,
                                      widget.sid,
                                      0,
                                      0);
                              Provider.of<Controller>(context, listen: false)
                                  .fetchremarkFromTable(widget.Cus_id);
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
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Icon(
                                  Icons.reviews,
                                  size: 16,
                                ),
                                backgroundColor: P_Settings.roundedButtonColor,
                              ),
                              title: Text(
                                value.remarkList[index]['rem_text'].toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
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
    );
  }
}
