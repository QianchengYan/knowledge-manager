import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_manager/pages/farm/FarmPage.dart';
import 'package:knowledge_manager/pages/flag/FlagPage.dart';
import 'package:knowledge_manager/pages/home/widget/home_drawer.dart';
import 'package:knowledge_manager/pages/schedule/schedule_page.dart';
import 'package:knowledge_manager/pages/task/TaskPage.dart';
import 'package:knowledge_manager/pages/world/WorldPage.dart';
import 'package:knowledge_manager/widgets/my_scaffold_widget.dart';
import 'package:knowledge_manager/widgets/my_title_bar.dart';
 
class HomePage extends StatefulWidget {
  // 根路由
  static final String routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _dialogExitApp(BuildContext context) async {
    // 如果是android返回桌面
    if(Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.categoty.HOME'
      );
      await intent.launch();
    }
    return Future.value(false);
  }
  
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
    // 增加返回监听，这是主页面，点击返回键退出程序
    return new WillPopScope(
      // 返回
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new MyScaffoldWidget(
        drawer: new HomeDrawer(),
        type: TabType.bottom,
        tabItems: tabs,
        tabPages: <Widget>[
          // new SchedulePage(key: scheduleKey), // 暂时不用key，不知道干什么的
          new SchedulePage(),
          new FlagPage(),
          new FarmPage(),
          new TaskPage(),
          new WorldPage(),
        ],
        onDoublePress: (index) {
          switch(index) {
            case 0:
              
          }
        },
        backgroundColor: Colors.orange,
        indicatorColor: Colors.white,
        title: MyTitleBar(
          
        ),
      ),
    );
  }
}