import 'package:flutter/material.dart';

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

  //////////////////snackbar///////////////////
  // _showSnackbar(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: Color.fromARGB(255, 143, 17, 8),
  //       duration: const Duration(seconds: 1),
  //       content: Text('Expired!!!!'),
  //       action: SnackBarAction(
  //         label: 'Dissmiss',
  //         textColor: Colors.yellow,
  //         onPressed: () {
  //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         },
  //       ),
  //     ),
  //   );
  // }

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
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
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Navigator.of(context).pop();
                        if (_formKey.currentState!.validate()) {
                          // print(uniqId);
                        }
                        // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.of(context).pop();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyDetails(
                                  // companyName: result!.companyName.toString(),
                                  )),
                        );
                      },
                      child:
                          Text(widget.isExpired ? "Register" : "Register"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
