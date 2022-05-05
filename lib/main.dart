import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/registrationScreen.dart';
import 'package:provider/provider.dart';
import 'components/commoncolor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
          primarySwatch: Colors.teal,
        ),
        scaffoldBackgroundColor: P_Settings.bodycolor,
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
      home: RegistrationScreen(isExpired: true,),
    );
  }
}
