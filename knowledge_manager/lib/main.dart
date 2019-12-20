import 'package:flutter/material.dart';
import 'package:knowledge_manager/pages/farm/FarmPage.dart';
import 'package:knowledge_manager/pages/flag/FlagPage.dart';
import 'package:knowledge_manager/pages/schedule/SchedulePage.dart';
import 'package:knowledge_manager/pages/task/TaskPage.dart';
import 'package:knowledge_manager/pages/world/WorldPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: new SchedulePage(),
      routes: {
        SchedulePage.routeName: (context) {
          return SchedulePage();
        },
        FlagPage.routeName: (context) {
          return FlagPage();
        },
        FarmPage.routeName: (context) {
          return FarmPage();
        },
        TaskPage.routeName: (context) {
          return TaskPage();
        },
        WorldPage.routeName: (context) {
          return WorldPage();
        },
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   _renderTab(icon, text) {
//     return new Tab(
//       child: new Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[new Icon(icon, size: 16), new Text(text)],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> tabs = [
//       _renderTab(Icons.save, "日程"),
//       _renderTab(Icons.save, "Flag"),
//       _renderTab(Icons.save, ""),
//       _renderTab(Icons.save, "任务"),
//       _renderTab(Icons.save, "世界"),
//     ];
//     return new Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: new AppBar(
//         title: new Text("标题？"),
//       ),
//       body:
//     );
//   }
// }
