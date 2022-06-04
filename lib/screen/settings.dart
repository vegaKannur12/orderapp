import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool rate=false ;
  String? option;
  int? edit;
  var res;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("pishku---$res");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Controller>(
          builder: (context, value, child) {
            // print("jhjdhf---${value.settingsList[0]["value"]}");
            // rate = value.settingsList[0]["value"] == 0 ? false : true;
            return Column(
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
                        value:this.rate,
                        onChanged: (value) async {
                          setState(() {
                            this.rate = value!;
                          });

                          // if (rate!) {
                          //   edit = 1;
                          // } else {
                          //   edit = 0;
                          // }
                          // OrderAppDB.instance.upadteCommonQuery("settings","value='${edit}'", "options='rate Edit'");

                          // Provider.of<Controller>(context, listen: false)
                          //   .selectFromSettings();
                          Provider.of<Controller>(context, listen: false)
                              .settingsRateOption = rate;
                        })
                  ],
                ),
                // SizedBox(height: size.height*0.4,),
                // ElevatedButton(onPressed: (){

                // }, child: Text("save"))
              ],
            );
          },
        ),
      ),
    );
  }
}
