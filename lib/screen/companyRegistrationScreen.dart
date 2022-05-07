import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

import '../components/commoncolor.dart';
import '../components/waveclipper.dart';
import 'companyDetailsscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String uniqId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
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
                            clipper: WaveClipper(), //set our custom wave clipper.
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
                      height: size.height * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: codeController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.business),
                          // hintText: 'What do people call you?',
                          labelText: 'Company Key',
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please Enter Company Key';
                          }
    
                          return null;
                        },
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
                            if (_formKey.currentState!.validate()) {
                              Provider.of<Controller>(context, listen: false)
                                  .postRegistration(codeController.text, context);
                            }
                          },
                          child: Text("Register")),
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

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(context: context, builder: (context) => exit(0));
}
