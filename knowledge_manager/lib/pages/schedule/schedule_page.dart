import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  static final String routeName = "farm";

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text("农场"),
      
    );
  }
}