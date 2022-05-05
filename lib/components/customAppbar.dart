import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  String title;
  CustomAppbar({required this.title});
  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:Text(widget.title.toString()),
    );
  }
}