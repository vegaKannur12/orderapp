import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List companyAttributes = [
    "logged in",
    "collection",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              itemCount: companyAttributes.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: companyAttributes[index],
                );
              }))),
    );
  }
}
