import 'package:flutter/material.dart';
 
class SchedulePage extends StatefulWidget {
  static final String routeName = "schedule";

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16), new Text(text)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(Icons.save, "日程"),
      _renderTab(Icons.save, "Flag"),
      _renderTab(Icons.save, ""),
      _renderTab(Icons.save, "任务"),
      _renderTab(Icons.save, "世界"),
    ];
    return new Scaffold(
      backgroundColor: Colors.blue,
      appBar: new AppBar(
        title: new Text("标题？"),
      ),
      body:
    );
  }
}