import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderapp/components/autocomplete.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/companyRegistrationScreen.dart';
import 'package:orderapp/screen/dashboard.dart';
import 'package:orderapp/screen/downloadedPage.dart';
import 'package:orderapp/screen/itemSelection.dart';
import 'package:orderapp/screen/orderForm.dart';
import 'package:orderapp/screen/paymentgate.dart';
import 'package:orderapp/screen/splashScreen.dart';
import 'package:orderapp/screen/staffLoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/commoncolor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cid=prefs.getString("company_id");
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Controller())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Raleway',
        primaryColor: P_Settings.bodycolor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ),
        // scaffoldBackgroundColor: P_Settings.bodycolor,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          headline6: TextStyle(
            fontSize: 25.0,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: PaymentGate(),
      // home: MyWaveClipper(),
    );
  }
}
