import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class TodayCollectionPage {
  Widget collectionPage(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<Controller>(
      builder: (context, value, child) {
        return Container(
          child: Column(
            children: [
              Text(
                "Todays Collection",
                style: TextStyle(
                    fontSize: 20,
                    color: P_Settings.wavecolor,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  // color: P_Settings.collection,
                  height: size.height * 0.7,
                  child: ListView.builder(
                    itemCount: value.collectionList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.reviews,
                              size: 16,
                            ),
                            backgroundColor: P_Settings.roundedButtonColor,
                          ),
                          title: Text(
                            "\u{20B9}${value.collectionList[index]['rec_amount'].toString()}",
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                              "\u{20B9}${value.collectionList[index]['rec_cusid'].toString()}"),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
