import 'package:flutter/material.dart';
import 'package:knowledge_manager/pages/farm/FarmPage.dart';
import 'package:knowledge_manager/pages/flag/FlagPage.dart';
import 'package:knowledge_manager/pages/home/home_page.dart';
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
      // 由于HomePage的route是‘/’根路由，所以可以不用写home
      // home: new HomePage(),
      routes: {
        HomePage.routeName: (context) {
          return HomePage();
        },
      },
    );
  }
}

