import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/style/my_icons.dart';
import 'package:knowledge_manager/common/utils/navigator_utils.dart';
import 'package:knowledge_manager/pages/farm/plantTabPage.dart';
import 'package:knowledge_manager/pages/farm/waterTabPage.dart';
import 'package:knowledge_manager/redux/my_state.dart';
import 'package:knowledge_manager/widgets/my_title_bar.dart';
import 'package:redux/redux.dart';

class FarmPage extends StatefulWidget {
  static final String routeName = "farm";

  @override
  _FarmPageState createState() => _FarmPageState();
}

// 继承SingleTickerProviderStateMixin，提供单个Ticker（每个动画帧调用它的回调一次）
class _FarmPageState extends State<FarmPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabViewController;
  // 子页面标题：
  List<Tab> _tabs;
  // 子页面：
  List<Widget> _tabPages;

  @override
  void initState() {
    super.initState();
    _tabs = <Tab>[
      Tab(text: "种植"),
      Tab(text: "灌溉"),
    ];
    _tabPages = [
      new PlantTabPage(),
      new WaterTabPage(),
    ];
    _tabViewController =
        new TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar_title = new TabBar(
      controller: _tabViewController,
      isScrollable: false, // 不可滚动
      // labelPadding: new EdgeInsets.all(30),
      indicatorSize: TabBarIndicatorSize.tab, // 指示器和 tab 等宽
      indicatorColor: Colors.white,
      tabs: _tabs,
    );

    List<List<Widget>> appBar_actions = [
      [new IconButton(icon: new Icon(Icons.search), onPressed: () {})],
      [new IconButton(icon: new Icon(Icons.ac_unit), onPressed: () {})],
    ];

    return new StoreBuilder<MyState>(builder: (context, store) {
      return new DefaultTabController(
          length: _tabPages.length,
          child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: appBar_title,
              centerTitle: true,
              actions: appBar_actions[_currentIndex],
            ),
            body: new TabBarView(
              controller: _tabViewController,
              children: _tabPages,
            ),
          ));
    });
  }
}
