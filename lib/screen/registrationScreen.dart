import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

import '../components/commoncolor.dart';
import '../components/waveclipper.dart';
import 'companyDetailsscreen.dart';

class RegistrationScreen extends StatefulWidget {
  bool isExpired = false;
  RegistrationScreen({required this.isExpired});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = new GlobalKey<FormState>();
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
    if (widget.isExpired) {
      Future<Null>.delayed(Duration.zero, () {
        // _showSnackbar(context);
      });
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Column(
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
                          // child: Text(
                          //   "LOGIN",
                          //   style: TextStyle(
                          //     fontSize: 28,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  )),
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
                        labelText: 'Company Code',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please Enter Company code';
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
                          Provider.of<Controller>(context, listen: false)
                              .postRegistration(codeController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompanyDetails(
                                    // companyName: result!.companyName.toString(),
                                    )),
                          );
                        },
                        child: Text("Register")),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
