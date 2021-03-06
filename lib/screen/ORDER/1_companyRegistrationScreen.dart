import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orderapp/components/waveclipper.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../components/commoncolor.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode? fieldFocusNode;
  TextEditingController codeController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String uniqId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deletemenu();
  }

  deletemenu() async {
    print("delete");
    // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
  }

  @override
  Widget build(BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper:
                                  WaveClipper(), //set our custom wave clipper.
                              child: Container(
                                padding: EdgeInsets.only(bottom: 50),
                                color: P_Settings.wavecolor,
                                height: size.height * 0.3,
                                alignment: Alignment.center,
                                //   child: Text(
                                //   "Company Registration",
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     // fontWeight: FontWeight.bold,
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.13,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.business),
                            // contentPadding: EdgeInsets.all(15.0),
                            // hintText: 'What do people call you?',
                            labelText: 'Company Key',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please Enter Company Key';
                            }
                            return null;
                          },
                          // scrollPadding: EdgeInsets.only(
                          //     top:100),
                          // focusNode: fieldFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        height: size.height * 0.05,
                        width: size.width * 0.3,
                        child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                Provider.of<Controller>(context, listen: false)
                                    .postRegistration(
                                        codeController.text, context);
                              }
                            },
                            child: Text("Register")),
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                      ),
                      Consumer<Controller>(
                        builder: (context, value, child) {
                          if (value.isLoading) {
                            return SpinKitCircle(
                              // backgroundColor:,
                              color: P_Settings.wavecolor,

                              // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                              // value: 0.25,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(context: context, builder: (context) => exit(0));
}
