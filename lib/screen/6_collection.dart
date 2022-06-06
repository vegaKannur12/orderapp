import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionPage extends StatefulWidget {
  String? os;
  CollectionPage({this.os});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<String> items=["Cash receipt","Google pay"];
  String selected="Cash receipt";
  String? os;
  TextEditingController amtController=TextEditingController();
  TextEditingController dscController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shared();
  }
  shared()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    os=prefs.getString("os");
    print("os---$os");
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Collection",
                  style: TextStyle(
                      color: P_Settings.wavecolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Series",
                          style: TextStyle(
                            fontSize: 15,
                          )),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.os.toString()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Date", style: TextStyle(fontSize: 15)),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "06-06-2022",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Transaction Mode", style: TextStyle(fontSize: 15)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(""),
                      ),
                      Container(
                        color: Colors.grey[200],
                        height: size.height*0.04,
                        child: DropdownButton<String>(
                          hint: Text("Select"),
                          isExpanded: true,
                          autofocus: false,
                          underline: SizedBox(),
                          elevation: 0,
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                  value: item.toString(),
                                  child: Container(
                                    width: size.width * 0.5,
                                    child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(item.toString())),
                                  )))
                              .toList(),
                          onChanged: (item) {
                            print("clicked");

                            if (item != null) {
                              setState(() {
                                selected = item;
                              });
                            }
                            // Provider.of<Controller>(context, listen: false).getArea(selected!);
                          },
                          value: selected,
                          // disabledHint: Text(selected ?? "null"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text("Amount", style: TextStyle(fontSize: 15)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: size.height * 0.04,
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField( 
                              controller: amtController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                              border: InputBorder.none,
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Discount", style: TextStyle(fontSize: 15)),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: size.height * 0.04,
                          width: size.width * 0.9,
                          color: P_Settings.collection,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: dscController,
                              keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                              border: InputBorder.none,
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text("Remarks", style: TextStyle(fontSize: 15)),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: size.width * 0.9,
                          child: TextField(
                            minLines:
                                4, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 20),
                              border: OutlineInputBorder(),
                              labelText: '',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Center(
                        child: Container(
                          width: size.width  * 0.3,
                          height: size.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                             double sum=double.parse( amtController.text)+double.parse( dscController.text);
                             if(sum>0){
                               
                             }
                            },
                            child: Text('Save'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
