import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<String> names = ["hdjd", "fhjdfhj", "fjhdf"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Container(
              height: size.height*0.9,
              width: double.infinity,
              child: Center(child: CircularProgressIndicator()));
          } else {
            return ListView.builder(
              itemCount: value.reportData.length,
              itemBuilder: (context, index) {
               
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(value.reportData[index]["name"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: P_Settings.wavecolor))
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.gps_fixed,
                                size: 15,
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(
                                value.reportData[index]["ad1"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                    fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          value.reportData[index]["mob"] == null
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Text(value.reportData[index]["mob"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ],
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              Icon(Icons.currency_rupee, size: 15),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(value.reportData[index]["bln"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700])),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text("(balance)")
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          value.reportData[index]["total"] == null
                              ? Container()
                              : Row(
                                  children: [
                                    Icon(Icons.currency_rupee, size: 15),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Text(value.reportData[index]["total"],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700])),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Text("(order)")
                                  ],
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              Container(
                                  color: Colors.green,
                                  width: size.width * 0.08,
                                  height: size.height * 0.03,
                                  child:
                                      value.reportData[index]["total"] != null
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )
                                          : null),
                              Container(
                                color: P_Settings.wavecolor,
                                width: size.width * 0.08,
                                height: size.height * 0.03,
                                child: value.reportData[index]["mode"] != null
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              Container(
                                color: P_Settings.roundedButtonColor,
                                width: size.width * 0.08,
                                height: size.height * 0.03,
                                child: value.reportData[index]["mode"] ==
                                            null &&
                                        value.reportData[index]["total"] == null
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : null,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
