import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  static final String routeName = "task";

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text("任务"),
      
    );
  }
}