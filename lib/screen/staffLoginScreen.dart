import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orderapp/components/commoncolor.dart';

import '../components/waveclipper.dart';

class StaffLogin extends StatelessWidget {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
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
          child: customTextField("Staff Name", controller1),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Flexible(
          flex: 2,
          child: customTextField("Password", controller1),
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
      String hinttext, TextEditingController controllerValue) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          // controller: controllerValue,
          decoration: InputDecoration(hintText: hinttext.toString()),
        ),
      ),
    );
  }
}

//Costom CLipper class with Path
