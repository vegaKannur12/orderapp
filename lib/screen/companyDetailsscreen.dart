import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customAppbar.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/staffLoginScreen.dart';
import 'package:provider/provider.dart';

class CompanyDetails extends StatefulWidget {
  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: P_Settings.detailscolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppbar(title: "Order App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Company Details",
              style: TextStyle(fontSize: 20, color: P_Settings.headingColor),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: P_Settings.detailscolor2,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: size.height * 0.03,
                  width: size.width * 0.9,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          // Future.delayed(
                          //     const Duration(milliseconds: 100),
                          //     () {
                          //   // Navigator.push(
                          //   //   context,
                          //   //   MaterialPageRoute(
                          //   //     builder: (context) => HomePage1(),
                          //   //   ),
                          //   // );
                          // });
                        },
                        title: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text("company name : G7 MARKETINGS"),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.book),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Address1           : ",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.book),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Address2            : MAVOOR ROAD",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.pin),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "PinCode              : ",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.business),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "CompanyPrefix  : VGMHD",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.landscape),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Land                    : 12397485",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Mobile                 : 13456789",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.design_services),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "GST                      : 32SGT45211RFDT",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.copy_rounded),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Country Code     : INR",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<Controller>(context, listen: false)
                                    .postRegistration("RONPBQ9AD5D");
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => StaffLogin()),
                                // );
                              },
                              child: Text("Download Data"),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
