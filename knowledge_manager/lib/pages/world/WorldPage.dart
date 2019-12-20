import 'package:flutter/material.dart';

class WorldPage extends StatefulWidget {
  static final String routeName = "world";

  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text("世界"),
      
    );
  }
}