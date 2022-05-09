import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';

class DownloadedPage extends StatefulWidget {
  // String cid;
  // DownloadedPage({required this.cid});

  @override
  State<DownloadedPage> createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  List<String> downloadItems = [
    "Account Heads",
    "Product Details",
    "Product category",
    "Company",
    "Images"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.wavecolor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(6.0),
          child: Consumer<Controller>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: P_Settings.wavecolor,

                  // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  // value: 0.25,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        // title: Text("Company Details",style: TextStyle(fontSize: 20),),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              height: size.height * 0.5,
              child: ListView.builder(
                itemCount: downloadItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: P_Settings.wavecolor),
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? cid = prefs.getString("cid");
                            if (downloadItems[index] == "Account Heads") {
                              Provider.of<Controller>(context, listen: false)
                                  .getaccountHeadsDetails(cid!);
                            }
                            if (downloadItems[index] == "Product category") {
                              Provider.of<Controller>(context, listen: false)
                                  .getProductCategory(cid!);
                            }
                            if (downloadItems[index] == "Company") {
                              Provider.of<Controller>(context, listen: false)
                                  .getProductCompany(cid!);
                            } if (downloadItems[index] == "Product Details") {
                              Provider.of<Controller>(context, listen: false)
                                  .getProductDetails(cid!);
                            }
                          },
                          icon: Icon(Icons.download),
                          color: Colors.white,
                        ),
                        title: Center(
                            child: Text(
                          downloadItems[index],
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: size.width * 0.4,
            height: size.height * 0.05,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                  primary: P_Settings.wavecolor,
                ),
                onPressed: () {},
                child: Text("Download all")),
          ),
          // SizedBox(height:20),
          // Consumer<Controller>(
          //   builder: (context, value, child) {
          //     if (value.isLoading) {
          //       return LinearProgressIndicator(
          //         backgroundColor: Colors.white,
          //         color: P_Settings.wavecolor,

          //         // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          //         // value: 0.25,
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
