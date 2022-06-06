import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';

class RemarkPage extends StatefulWidget {
  const RemarkPage({Key? key}) : super(key: key);

  @override
  State<RemarkPage> createState() => _RemarkPageState();
}

class _RemarkPageState extends State<RemarkPage> {
  DateTime now = DateTime.now();
  String? date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('yyyy-MM-dd').format(now);
    print("date...${date}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
                          minLines:
                              3, // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 20),
                            border: OutlineInputBorder(),
                            labelText: '',
                            hintText: 'Type here...'
                          ),
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
                          onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
