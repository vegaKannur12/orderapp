import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customToast.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerCreation extends StatefulWidget {
  String? os;
  String? sid;

  CustomerCreation({required this.sid, required this.os});

  @override
  State<CustomerCreation> createState() => _CustomerCreationState();
}

class _CustomerCreationState extends State<CustomerCreation> {
  String? selected;
  TextEditingController cusname = TextEditingController();
  String? gtype;
  CustomToast tst = CustomToast();

  int customerCount = 0;
  List<Map<String, dynamic>> gtp = [
    {
      "id": "0",
      "gtp": "Local",
    },
    {
      "id": "1",
      "gtp": "Inter_state",
    }
  ];
  TextEditingController addr1 = TextEditingController();
  TextEditingController addr2 = TextEditingController();
  TextEditingController addr3 = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController mob = TextEditingController();
  //  String? os;
  //  String? sid;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // shared();
    print("widget----${widget.sid}");
    Provider.of<Controller>(context, listen: false).getArea(widget.sid!);
  }

  // shared() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //  os = prefs.getString("os");
  //  sid = prefs.getString("sid");
  //  print("sid==$sid");
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                          "Customer Creation",
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
                              Text("Customer Name ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: cusname,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text("Area ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
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
                                  items: value.areDetails
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item["aid"].toString(),
                                          child: Container(
                                            width: size.width * 0.5,
                                            child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                    item["aname"].toString())),
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
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text("GType ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                color: Colors.grey[200],
                                height: size.height * 0.04,
                                child: DropdownButton<String>(
                                  value: gtype,
                                  hint: Text("Select"),
                                  isExpanded: true,
                                  autofocus: false,
                                  underline: SizedBox(),
                                  elevation: 0,
                                  items: gtp
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item["id"].toString(),
                                          child: Container(
                                            width: size.width * 0.5,
                                            child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                    item["gtp"].toString())),
                                          )))
                                      .toList(),
                                  onChanged: (item) {
                                    print("clicked");

                                    if (item != null) {
                                      setState(() {
                                        gtype = item;
                                      });
                                      print("se;ected---$item");
                                    }
                                  },

                                  // disabledHint: Text(selected ?? "null"),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Text("Address 1", style: TextStyle(fontSize: 15)),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: addr1,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text("Address 2", style: TextStyle(fontSize: 15)),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: addr2,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        )),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: size.height * 0.01,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text("Address 3",
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
                                        controller: addr3,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text("Phone Number",
                                  style: TextStyle(fontSize: 15)),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: phoneNo,
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
                              Text("Mobile number",
                                  style: TextStyle(fontSize: 15)),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.9,
                                  color: P_Settings.collection,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: mob,
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        )),
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
                                      customerCount = customerCount + 1;
                                      String ac_code =
                                          "${widget.os} " + "${customerCount}";
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      var account = await OrderAppDB.instance
                                          .createCustomer(
                                              ac_code,
                                              cusname.text,
                                              gtype!,
                                              addr1.text,
                                              addr2.text,
                                              addr3.text,
                                              selected!,
                                              phoneNo.text,
                                              "0",
                                              0,
                                              "0",
                                              "0",
                                              mob.text,
                                              "0",
                                              "0",
                                              "");
                                      cusname.clear();
                                      addr1.clear();
                                      addr2.clear();
                                      addr3.clear();
                                      phoneNo.clear();
                                      tst.toast("Customer created!!");
                                    },
                                    child: Text('Save'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              // Center(
                              //   child: ValueListenableBuilder(
                              //       // valueListenable: visible,
                              //       builder: (BuildContext context, bool v,
                              //           Widget? child) {
                              //         print("value===${visible.value}");
                              //         return Visibility(
                              //           visible: v,
                              //           child: Text(
                              //             "Please fill corresponding fields!!!",
                              //             style: TextStyle(color: Colors.red),
                              //           ),
                              //         );
                              //       }),
                              // )
                            ],
                          ),
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
