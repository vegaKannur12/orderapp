import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class HistoryPopup {
  Future buildPopupDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: Consumer<Controller>(builder: (context, value, child) {
              if (value.isLoading) {
                return CircularProgressIndicator();
              } else {
                return DataTable(
                  horizontalMargin: 0,
                  headingRowHeight: 30,
                  dataRowHeight: 35,
                  //     MaterialStateColor.resolveWith((states) => Colors.yellow),
                  columnSpacing: 0,
                  showCheckboxColumn: false,

                  border: TableBorder.all(width: 1, color: Colors.black),
                  columns: getColumns(value.tableHistorydataColumn),
                  rows: getRowss(value.historydataList),
                );
              }
            }),

            // actions: [
            //   ElevatedButton(onPressed: (){
            //     Navigator.pop(context);
            //   }, child: Text("ok"))
            // ],
          );
        });
  }

  List<DataColumn> getColumns(List<String> columns) {
    // print("columns---${columns}");
    String behv;
    String colsName;
    return columns.map((String column) {
      // double strwidth = double.parse(behv[3]);
      // strwidth = strwidth * 10; //
      return DataColumn(
        label: Container(
          width: 100,
          child: Text(
            column,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            // textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
          ),
          // ),
        ),
      );
    }).toList();
  }

  ////////////////////////////////////////////
  List<DataRow> getRowss(List<Map<String, dynamic>> rows) {
    List<String> newBehavr = [];
    // print("rows---$rows");
    return rows.map((row) {
      return DataRow(
        // color: MaterialStateProperty.all(Colors.green),
        cells: getCelle(row),
      );
    }).toList();
  }
/////////////////////////////////////////////

  List<DataCell> getCelle(Map<String, dynamic> data) {
    // print("data--$data");
    //  double  sum=0;
    List<DataCell> datacell = [];

    // print("main header---$mainHeader");

    data.forEach((key, value) {
      datacell.add(
        DataCell(
          Container(
            //  width:100,
            // width: mainHeader[k][3] == "1" ? 70 : 30,
            alignment: Alignment.center,
            //     ? Alignment.centerLeft
            //     : Alignment.centerRight,
            child: Text(
              value.toString(),
              // textAlign:
              //     mainHeader[k][1] == "L" ? TextAlign.left : TextAlign.right,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      );
    });

    // print(datacell.length);
    return datacell;
  }
}
