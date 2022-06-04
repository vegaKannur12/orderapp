import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool rate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: size.height*,
                // )
                Text(
                  "Enable Rate Edit option  ? ",
                  style: TextStyle(fontSize: 17),
                ),
                Checkbox(
                    value: this.rate,
                    onChanged: (value) {
                      setState(() {
                        this.rate = value!;
                      });
                      Provider.of<Controller>(context, listen: false)
                          .settingsRateOption = rate;
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
