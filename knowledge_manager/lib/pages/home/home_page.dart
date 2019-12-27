import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/localization/default_localizations.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/common/utils/common_utils.dart';
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
  static final String routeName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = new PageController();

  int _currentIndex = 0;

  // 标题：appBar 和 bottomItem 用到
  static const List<String> titles = [
    "日程",
    "Flag",
    "联系人",
    "发现",
  ];
  static const String title_center = "知识农场";
  // appBar右侧iconButton：appBar 用到
  List<List<Widget>> actions = [
    [
      new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {},
      )
    ],
    [
      new IconButton(
        icon: new Icon(Icons.ac_unit),
        onPressed: () {},
      )
    ],
    [
      new IconButton(
        icon: new Icon(Icons.ac_unit),
        onPressed: () {},
      ),
      new IconButton(
        icon: new Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    ],
    [
      new IconButton(
        icon: new Icon(Icons.hd),
        onPressed: () {},
      )
    ],
  ];
  // icon：bottomItem用到
  static const List<IconData> icons = [
    Icons.tab,
    Icons.flag,
    Icons.account_circle,
    Icons.ac_unit,
  ];
  static const icon_center = Icons.dashboard;
  // tabPages: body 用到
  List<Widget> tabPages = <Widget>[
    // new SchedulePage(key: scheduleKey), // 暂时不用key，不知道干什么的
    new SchedulePage(),
    new FlagPage(),
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

  _PageViewChanged(index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              title: new Text(titles[_currentIndex]), // 中间的标题
              centerTitle: true, // 标题居中
              actions: actions[_currentIndex], // 右侧控件
              leading: new Container(
                padding: new EdgeInsets.all(3),
                child: new ClipOval(
                  child: new Image.asset(MyImages.DEFAULT_USER_AVATAR),
                ),
              )),
          body: new PageView(
            controller: _pageController,
            children: tabPages,
            onPageChanged: _PageViewChanged, // 事件处理
            // physics: new NeverScrollableScrollPhysics(),// 禁止左右滑动切换界面
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            // notchMargin: 1.0,
            child: new Container(
              height: 55.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildBotomItem(_currentIndex, 0, icons[0], titles[0],
                      Theme.of(context).primaryColor),
                  buildBotomItem(_currentIndex, 1, icons[1], titles[1],
                      Theme.of(context).primaryColor),
                  buildBotomItem(_currentIndex, -1, null, title_center,
                      Theme.of(context).primaryColor),
                  buildBotomItem(_currentIndex, 2, icons[2], titles[2],
                      Theme.of(context).primaryColor),
                  buildBotomItem(_currentIndex, 3, icons[3], titles[3],
                      Theme.of(context).primaryColor),
                ],
              ),
            ),
          ),
          floatingActionButton: new Container(
            height: 50,
            width: 50,
            // padding: new EdgeInsets.all(10),
            margin: new EdgeInsets.only(top: 20),
            child: new FloatingActionButton(
              onPressed: () {
                NavigatorUtils.goFarm(context);
              },
              child: new Icon(icon_center),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      }),
    );
  }

  buildBotomItem(int selectIndex, int index, IconData iconData, String title,
      Color itemColor) {
    //未选中状态的样式
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
    MaterialColor iconColor = Colors.grey;
    double iconSize = 20;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 8.0);

    if (selectIndex == index) {
      //选中状态的文字样式
      textStyle = TextStyle(fontSize: 13.0, color: itemColor);
      //选中状态的按钮样式
      iconColor = itemColor;
      iconSize = 25;
      padding = EdgeInsets.only(top: 6.0);
    }
    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize,
                ),
                Text(
                  title,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Container(
          color: Colors.white,
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
          ),
        ),
      );
    }
    Widget item = Expanded(
      flex: 1,
      child: new GestureDetector(
        onTap: () {
          _navigationBottomItemTap(index);
        },
        child: SizedBox(
          height: 52,
          child: padItem,
        ),
      ),
    );
    return item;
  }

  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('退出App'),
            content: new Text('一分耕耘一分收获\n是否离开'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('不'),
              ),
              new FlatButton(
                onPressed: () async {
                  await pop();
                },
                child: new Text('是的'),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
