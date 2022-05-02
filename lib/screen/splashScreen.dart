
import 'package:flutter/material.dart';
import 'package:orderapp/screen/registrationScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  navigate() async {
    await Future.delayed(Duration(seconds: 2), () async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationScreen(isExpired: true)),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<Controller>(context, listen: false).getCategoryReport();
    navigate();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceInOut,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: size.height * 0.4,
          ),
          Image.asset("asset/logo_black_bg.png"),
        ],
      )),
    );
  }
}
