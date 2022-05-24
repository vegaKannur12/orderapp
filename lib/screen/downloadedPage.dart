import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controller.dart';

class DownloadedPage extends StatefulWidget {
  String? type;
  DownloadedPage({this.type});

  @override
  State<DownloadedPage> createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  String? cid;
  List<String> downloadItems = [
    "Account Heads",
    "Product Details",
    "Product category",
    "Company",
    "Images"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCid();
  }

  getCid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: widget.type == ""
          ? AppBar(
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
            )
          : null,
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
                            if (downloadItems[index] == "Account Heads") {
                              await OrderAppDB.instance
                                  .deleteFromTableCommonQuery(
                                      "accountHeadsTable", "");
                              Provider.of<Controller>(context, listen: false)
                                  .getaccountHeadsDetails(cid!);
                            }
                            if (downloadItems[index] == "Product category") {
                              await OrderAppDB.instance
                                  .deleteFromTableCommonQuery(
                                      "productsCategory", "");
                              Provider.of<Controller>(context, listen: false)
                                  .getProductCategory(cid!);
                            }
                            if (downloadItems[index] == "Company") {
                              await OrderAppDB.instance
                                  .deleteFromTableCommonQuery(
                                      "companyTable", "");
                              Provider.of<Controller>(context, listen: false)
                                  .getProductCompany(cid!);
                            }
                            if (downloadItems[index] == "Product Details") {
                              await OrderAppDB.instance
                                  .deleteFromTableCommonQuery(
                                      "productDetailsTable", "");
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
                onPressed: () async {
                  await OrderAppDB.instance
                      .deleteFromTableCommonQuery("accountHeadsTable", "");
                  await OrderAppDB.instance
                      .deleteFromTableCommonQuery("productsCategory", "");
                  await OrderAppDB.instance
                      .deleteFromTableCommonQuery("companyTable", "");
                  await OrderAppDB.instance
                      .deleteFromTableCommonQuery("productDetailsTable", "");
                      ///////////////////////////////////////////
                  Provider.of<Controller>(context, listen: false)
                      .getaccountHeadsDetails(cid!);

                  Provider.of<Controller>(context, listen: false)
                      .getProductCategory(cid!);

                  Provider.of<Controller>(context, listen: false)
                      .getProductCompany(cid!);

                  Provider.of<Controller>(context, listen: false)
                      .getProductDetails(cid!);
                },
                child: Text("Download all")),
          ),
          SizedBox(height: 20),
          widget.type == ""
              ? Container()
              : Consumer<Controller>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return CircularProgressIndicator(
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
        ],
      ),
    );
  }
}
