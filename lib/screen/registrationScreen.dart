import 'package:flutter/material.dart';
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
    // if (widget.isExpired) {
    //   Future<Null>.delayed(Duration.zero, () {
    //     // _showSnackbar(context);
    //   });
    // }
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
      },
      child: Scaffold(
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
                            // Obtain shared preferences.
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            Provider.of<Controller>(context, listen: false)
                                .postRegistration(codeController.text);
                            
                            prefs.setString("company_id", codeController.text);

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
          )),
    );
  }
}
