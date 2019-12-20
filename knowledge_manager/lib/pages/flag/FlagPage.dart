import 'package:flutter/material.dart';

class FlagPage extends StatefulWidget {
  static final String routeName = "flag";

  @override
  _FlagPageState createState() => _FlagPageState();
}

class _FlagPageState extends State<FlagPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text("flag"),
      
    );
  }
}