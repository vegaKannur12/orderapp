import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ORDER/1_companyRegistrationScreen.dart';
import 'package:orderapp/screen/ORDER/3_staffLoginScreen.dart';
import 'package:orderapp/screen/ORDER/5_dashboard.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? cid;
  String? st_uname;
  String? st_pwd;

  navigate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      cid = prefs.getString("company_id");
      st_uname = prefs.getString("st_username");
      st_pwd = prefs.getString("st_pwd");

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       // builder: (context) =>RegistrationScreen()),
      //       builder: (context) => cid != null
      //           ? st_uname != null && st_pwd != null
      //               ? Dashboard()
      //               : StaffLogin()
      //           : RegistrationScreen()),
      // );
      Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false, // set to false
            pageBuilder: (_, __, ___) => cid != null
                ? st_uname != null && st_pwd != null
                    ? Dashboard()
                    : StaffLogin()
                : RegistrationScreen()),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();

    navigate();
  }

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat();
  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.bounceInOut,
  // );
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: P_Settings.wavecolor,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "asset/logo_black_bg.png",
                )),
          ],
        )),
      ),
    );
  }
}
