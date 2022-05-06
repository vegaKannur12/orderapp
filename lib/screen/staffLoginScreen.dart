import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orderapp/components/commoncolor.dart';

import '../components/waveclipper.dart';

class StaffLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: P_Settings.wavecolor,
          actions: [
            IconButton(
                onPressed: () {
                  exit(0);
                },
                icon: Icon(Icons.close))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 175,
                child: Stack(
                  children: <Widget>[
                    //stack overlaps widgets
                    ClipPath(
                      //upper clippath with less height
                      clipper: WaveClipper(), //set our custom wave clipper.
                      child: Container(
                        padding: EdgeInsets.only(bottom: 50),
                        color: P_Settings.wavecolor,
                        height: size.height * 0.3,
                        alignment: Alignment.center,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: size.height * 0.05,
            ),
            Flexible(
              flex: 2,
              child: customTextField("Username", controller1, "staff"),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Flexible(
              flex: 2,
              child: customTextField("Password", controller1, "password"),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // primary: Colors.red,
                  ),
              onPressed: () {},
              child: Text("Login"),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Flexible(
              flex: 2,
              child: customTextField("Password", controller1, "password"),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // primary: Colors.red,
                  ),
              onPressed: () {},
              child: Text("Login"),
            ),
          ],
        ));
  }

/////////////////////////////////////////////////////////////////////////
  Widget customTextField(
      String hinttext, TextEditingController controllerValue, String type) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          obscureText: type == "password" ? true : false,
          // controller: controllerValue,
          decoration: InputDecoration(hintText: hinttext.toString()),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please Enter ${text}';
            }
            return null;
          },
        ),
      ),
    );
  }
}

//Costom CLipper class with Path
