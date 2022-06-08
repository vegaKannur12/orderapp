import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

enum WidgetMarker {
  area,
  date,
  orderAmount,
  balanceAmount,
  collectionAmount,
  remark
}

class FilterReport extends StatefulWidget {
  const FilterReport({Key? key}) : super(key: key);

  @override
  State<FilterReport> createState() => _FilterReportState();
}

class _FilterReportState extends State<FilterReport> {
  RangeValues _currentRangeValues = const RangeValues(20, 500);
  WidgetMarker selectedWidgetMarker = WidgetMarker.date;

  List orderAmount = [
    "1-500",
    "501-1000",
    "1001-1500",
    "1501-2000",
    "2001-2500",
  ];
  List dateSelect = [
    "Today",
    "Last 7 Days",
    "This Month",
    "Between date",
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool isChecked = false;

    /////////////// date filter //////////////
    Widget dateFilter() {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dateSelect.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.done,
                    size: 16,
                  ),
                  title: Text(
                    dateSelect[index],
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 127, 192, 223),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {},
            child: Text("Ok"),
          )
        ],
      );
    }

    ////////////////// area filter /////////////////////
    Widget areaFilter() {
      return Container(
        height: size.height * 0.9,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Area",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Checkbox(
                      checkColor: Colors.white,
                      // fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 127, 192, 223),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {},
              child: Text("Ok"),
            )
          ],
        ),
      );
    }

    //////////////////////// Order Amount //////////////////////
    ///
    Widget orderAmountFilter() {
      return Column(
        children: [
          Text("Select order Amount"),
          Expanded(
            child: ListView.builder(
              itemCount: orderAmount.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    orderAmount[index],
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    // fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 127, 192, 223),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {},
            child: Text("Ok"),
          )
        ],
      );
    }

    ///////////////// balance amount ///////////////
    Widget balanceAmountFilter() {
      return Column(
        children: [
          Text("Select balance Amount"),
          SizedBox(
            height: size.height * 0.04,
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 1000,
            divisions: 10,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            // onChangeStart: (RangeValues values) =>
            //     _currentRangeValues.start.round().toString(),
            // onChangeEnd: (RangeValues values) =>
            //     _currentRangeValues.end.round().toString(),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                print("_currentRangeValues$_currentRangeValues");
              });
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 127, 192, 223),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {},
            child: Text("Ok"),
          )
        ],
      );
    }

    ////////////////// collection amount filter ///////////////////
    Widget collectionAmountFilter() {
      return Column(
        children: [
          Text("Collection Amount"),
          SizedBox(
            height: size.height * 0.04,
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 1000,
            divisions: 10,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            // onChangeStart: (RangeValues values) =>
            //     _currentRangeValues.start.round().toString(),
            // onChangeEnd: (RangeValues values) =>
            //     _currentRangeValues.end.round().toString(),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                print("_currentRangeValues$_currentRangeValues");
              });
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 127, 192, 223),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {},
            child: Text("Ok"),
          )
        ],
      );
    }

    //////////////////////Remarks ////////////////////////
    Widget remarkFilter() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.done,
                size: 15,
              ),
              SizedBox(
                width: size.width * 0.03,
                height: size.height * 0.08,
              ),
              Text("Remarked"),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.done,
                size: 15,
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Text("Not Remarked"),
            ],
          ),
        ],
      );
    }

    Widget getCustomContainer() {
      print("inside switch case");
      switch (selectedWidgetMarker) {
        case WidgetMarker.area:
          print("area");

          return areaFilter();
        case WidgetMarker.date:
          print("date");
          return dateFilter();
        case WidgetMarker.orderAmount:
          print("order");

          return orderAmountFilter();
        case WidgetMarker.balanceAmount:
          return balanceAmountFilter();
        case WidgetMarker.collectionAmount:
          return collectionAmountFilter();
        case WidgetMarker.remark:
          return remarkFilter();
      }
    }

    ///////////////////////////////////////
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: size.height * 0.9,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 2, right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "FILTER",
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      color: P_Settings.collection,
                      height: size.height * 9,
                      width: size.width * 0.4,
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWidgetMarker = WidgetMarker.date;
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.height * 0.03,
                              child: Text("Date"),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWidgetMarker = WidgetMarker.area;
                                print(
                                    "selectedWidgetMarker $selectedWidgetMarker");
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.height * 0.035,
                              child: Text("Area"),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWidgetMarker = WidgetMarker.orderAmount;
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.height * 0.035,
                              child: Text("Order Amount"),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWidgetMarker =
                                    WidgetMarker.balanceAmount;
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.height * 0.035,
                              child: Text("Balance Amount"),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWidgetMarker =
                                    WidgetMarker.collectionAmount;
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.height * 0.035,
                              child: Text("Collection Amount"),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWidgetMarker = WidgetMarker.remark;
                              });
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: size.height * 0.035,
                              child: Text("Remark"),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      height: size.height * 9,
                      width: size.width * 0.55,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            getCustomContainer();
                          });
                        },
                        child: getCustomContainer(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
