import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/1_companyRegistrationScreen.dart';
import 'package:orderapp/screen/2_companyDetailsscreen.dart';
import 'package:orderapp/screen/3_staffLoginScreen.dart';
import 'package:orderapp/screen/5_dashboard.dart';
import 'package:orderapp/screen/6_historypage.dart';
import 'package:orderapp/screen/0_splashScreen.dart';
import 'package:orderapp/screen/6.1_filter_Report.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/commoncolor.dart';
import 'package:ota_update/ota_update.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cid = prefs.getString("company_id");
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Controller())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
 late OtaEvent currentEvent;

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
      home: SplashScreen(),
      // home: MyWaveClipper(),
    );
  }

  ////////////////////////////////
  Future<void> tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute(
        'https://internal1.4q.sk/flutter_hello_world.apk',
        destinationFilename: 'flutter_hello_world.apk',
        //FOR NOW ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
        sha256checksum:
            'd6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478',
      )
          .listen(
        (OtaEvent event) {
          currentEvent = event;
          // setState(() => currentEvent = event
        },
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }
}
