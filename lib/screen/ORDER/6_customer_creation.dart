import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class CustomerCreation extends StatefulWidget {
  String type;
  String title;
  CustomerCreation({required this.type, required this.title});

  @override
  State<CustomerCreation> createState() => _CustomerCreationState();
}

class _CustomerCreationState extends State<CustomerCreation> {
  TextEditingController cusname = TextEditingController();
  TextEditingController addr1 = TextEditingController();
  TextEditingController addr2 = TextEditingController();
  TextEditingController addr3 = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController mob = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                              SizedBox(
                                height: size.height * 0.01,
                              ),
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
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());

                                      // visible.value = false;

                                      // await OrderAppDB.instance
                                      //     .insertCollectionTable(
                                      //         formattedDate!,
                                      //         widget.cuid!,
                                      //         widget.os!,
                                      //         selected!,
                                      //         double.parse(
                                      //             amtController.text),
                                      //         dscController.text,
                                      //         noteController.text,
                                      //         widget.sid!,
                                      //         0,
                                      //         0);

                                      // await OrderAppDB.instance.upadteCommonQuery('accountHeadsTable',"ba='${item["order_id"]}'","os='${os}' AND customerid='${customerId}'" );

                                      //  }
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
