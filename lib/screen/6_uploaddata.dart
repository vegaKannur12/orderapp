import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class Uploaddata extends StatefulWidget {
  const Uploaddata({ Key? key }) : super(key: key);

  @override
  State<Uploaddata> createState() => _UploaddataState();
}

class _UploaddataState extends State<Uploaddata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(onPressed: (){
             Provider.of<Controller>(context, listen: false).uploadData();
          }, icon: Icon(Icons.arrow_upward ),label: Text("Upload"))
        ],
      ),
    );
  }
}