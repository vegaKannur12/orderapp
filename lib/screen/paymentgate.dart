import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class PaymentGate extends StatefulWidget {
  const PaymentGate({Key? key}) : super(key: key);

  @override
  _PaymentGateState createState() => _PaymentGateState();
}

class _PaymentGateState extends State<PaymentGate> {
  // The group value
  var _result;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Payment Method',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                  title: const Text('UPI'),
                  value: 1,
                  groupValue: _result,
                  onChanged: (value) {
                    setState(() {
                      _result = value;
                    });
                  }),
              RadioListTile(
                  title: const Text('Wallets'),
                  value: 2,
                  groupValue: _result,
                  onChanged: (value) {
                    setState(() {
                      _result = value;
                    });
                  }),
              RadioListTile(
                  title: const Text('Credit /Debit /ATM Card'),
                  value: 3,
                  groupValue: _result,
                  onChanged: (value) {
                    setState(() {
                      _result = value;
                    });
                  }),
              RadioListTile(
                  title: const Text('Net Banking'),
                  value: 4,
                  groupValue: _result,
                  onChanged: (value) {
                    setState(() {
                      _result = value;
                    });
                  }),
              const SizedBox(height: 25),
              // Text(_result == 3 ? 'Correct!' : 'Please chose the right answer!')
              _result == 2
                  ? Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: size.height * 0.09,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 238, 237, 237),
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: Text('Paytm'),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                child: Text('PhonePe'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text(""),
              _result == 1
                  ? Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: size.height * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 238, 237, 237),
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: Text('GPay'),
                              ),
                              OutlinedButton(
                                onPressed: () {},
                                child: Text('PhonePe'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text(""),
              _result == 4
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: size.height * 0.3,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 238, 237, 237),
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('State Bank of India'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('Axis Bank'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('ICICI Netbanking'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('HDFC Bank'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(""),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: size.height * 0.1,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 238, 237, 237),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Price Details",
                          style: TextStyle(color: P_Settings.extracolor),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Total Product Price :"),
                            Text("  200"),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Order Total  :"),
                            Text("  500"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
