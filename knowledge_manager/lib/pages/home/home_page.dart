import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/pages/farm/FarmPage.dart';
import 'package:knowledge_manager/pages/flag/FlagPage.dart';
import 'package:knowledge_manager/pages/home/widget/home_drawer.dart';
import 'package:knowledge_manager/pages/schedule/schedule_page.dart';
import 'package:knowledge_manager/pages/task/TaskPage.dart';
import 'package:knowledge_manager/pages/world/WorldPage.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/widgets/my_scaffold_widget.dart';
import 'package:knowledge_manager/widgets/my_title_bar.dart';

class HomePage extends StatefulWidget {
  // 根路由
  static final String routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = new PageController();

  int _currentIndex = 0;
  static const List<String> titles = [
    "日程",
    "Flag",
    "",
    "任务",
    "世界",
  ];
  static const List<IconData> icons = [
    Icons.home,
    Icons.flag,
    Icons.fiber_manual_record,
    Icons.tab,
    Icons.work,
  ];
  List<BottomNavigationBarItem> _rendbottomItems (){
    List<BottomNavigationBarItem> list = List();
    for (var i = 0; i < titles.length; i++) {
      list.add(new BottomNavigationBarItem(
        icon: Icon(icons[i]),
        title: new Text(titles[i]),
      ));
    }
    return list;
  }
  List<BottomNavigationBarItem> bottomItems = (() {
    List<BottomNavigationBarItem> list = List();
    for (var i = 0; i < titles.length; i++) {
      list.add(new BottomNavigationBarItem(
        icon: Icon(icons[i]),
        title: new Text(titles[i]),
      ));
    }
    return list;
  })();

  List<Widget> tabPages = <Widget>[
    // new SchedulePage(key: scheduleKey), // 暂时不用key，不知道干什么的
    new SchedulePage(),
    new FlagPage(),
    new FarmPage(),
    new TaskPage(),
    new WorldPage(),
  ];

  _navigationBottomItemTap(index) {
    print("==============");
    print(index);
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    // 不想要动画
    _pageController.jumpTo(MediaQuery.of(context).size.width * index);
  }

  @override
  Widget build(BuildContext context) {
    MyTitleBar title = new MyTitleBar(
      // MyLocalizations.of(context).currentLocalization.app_name,
      "hh",
      iconData: MyICons.MAIN_SEARCH,
      needRightLocalIcon: true,
      onPressed: () {
        NavigatorUtils.goLogin(context);
      },
    );
    bottomItems = _rendbottomItems();

    // 增加返回监听，这是主页面，点击返回键退出程序
    return new WillPopScope(
      // 返回
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new StoreBuilder<MyState>(builder: (context, store) {
        return new Scaffold(
          drawer: new HomeDrawer(),
          appBar: new AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: title,
          ),
          body: new PageView(
            controller: _pageController,
            children: tabPages,
          ),
          bottomNavigationBar: new BottomNavigationBar(
            // items: const <BottomNavigationBarItem>[
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.home),
            //     title: Text('Home'),
            //   ),
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.business),
            //     title: Text('Business'),
            //   ),
            //   BottomNavigationBarItem(
            //     icon: Icon(Icons.school),
            //     title: Text('School'),
            //   ),
            // ],
            items: bottomItems,
            currentIndex: _currentIndex,
            backgroundColor: store.state.themeData.primaryColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.orange,
            onTap: _navigationBottomItemTap,
            type: BottomNavigationBarType.fixed,
          ),
        );
      }),
    );
  }

  Future<bool> _dialogExitApp(BuildContext context) async {
    print("=================return android home");

    // 如果是android返回桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          category: 'android.intent.categoty.HOME');
      await intent.launch();
    }
    return Future.value(false);
  }
}
