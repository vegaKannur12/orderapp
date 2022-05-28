import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class HistoryPage extends StatefulWidget {

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> tablecolumn = [
    "Or.No",
    "Date",
    "Customer Id",
    "No.items",
    "Total"
  ];
  Map<String, dynamic> total = {};
  List<Map<String, dynamic>> newJson = [];
  final rows = <DataRow>[];
  String? behv;

  List<String>? colName;
  List<String> tableColumn = [];
  List<String> behvr = [];
  Map<String, dynamic> mainHeader = {};
  int col = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    if (col <= 5) {
      width / col;
    }
    return Scaffold(
      appBar: AppBar(
          // title: Text("History"),
          ),
      body: SingleChildScrollView(
        // width: double.infinity,
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Order History",
                style: TextStyle(color: P_Settings.extracolor, fontSize: 17),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              DataTable(
                dividerThickness: 2,
                horizontalMargin: 0,
                headingRowHeight: 30,
                dataRowHeight: 35,
                // dataRowColor:
                //     MaterialStateColor.resolveWith((states) => Colors.yellow),
                columnSpacing: 0,
                border: TableBorder.all(
                    width: 1, color: Color.fromARGB(255, 212, 209, 209)),
                columns: getColumns(tablecolumn),
                rows: getRowss(newJson),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////////////
  List<DataColumn> getColumns(List<String> columns) {
    // print("columns---${columns}");
    String behv;
    String colsName;
    return columns.map((String column) {
      return DataColumn(
        label: Container(
          width: 76,
          child: Text(
            column,
            style: TextStyle(fontSize: 13),
            // textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
          ),
          // ),
        ),
      );
    }).toList();
  }

  ///////////////////////////////////
  List<DataRow> getRowss(List<Map<String, dynamic>> rows) {
    List<String> newBehavr = [];
    // print("rows---$rows");
    return newJson.map((row) {
      return DataRow(
        // color: MaterialStateProperty.all(Colors.green),
        cells: getCelle(row),
      );
    }).toList();
  }

  ////////////////////////////////////
  List<DataCell> getCelle(Map<String, dynamic> data) {
    print("data--$data");
    //  double  sum=0;
    List<DataCell> datacell = [];
    mainHeader.remove('rank');
    // print("main header---$mainHeader");

    data.forEach(
      (key, value) {
        mainHeader.forEach(
          (k, val) {
            datacell.add(
              DataCell(
                Container(
                  //  width:100,
                  // width: mainHeader[k][3] == "1" ? 70 : 30,
                  // alignment: mainHeader[k][1] == "L"
                  //     ? Alignment.centerLeft
                  //     : Alignment.centerRight,
                  child: Text(
                    value.toString(),
                  ),
                ),
              ),
            );

            // print("val${val}");
          },
        );
        // print("value---$value");
      },
    );
    // print(datacell.length);
    return datacell;
  }
}
