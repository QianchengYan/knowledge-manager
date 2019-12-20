import 'package:flutter/material.dart';

class FarmPage extends StatefulWidget {
  static final String routeName = "farm";

  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text("农场"),
      
    );
  }
}