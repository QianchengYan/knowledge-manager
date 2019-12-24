import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/pages/farm/plantTabPage.dart';
import 'package:knowledge_manager/pages/farm/waterTabPage.dart';
import 'package:knowledge_manager/redux/my_state.dart';

class FarmPage extends StatefulWidget {
  static final String routeName = "farm";

  @override
  _FarmPageState createState() => _FarmPageState();
}

// 继承SingleTickerProviderStateMixin，提供单个Ticker（每个动画帧调用它的回调一次）
class _FarmPageState extends State<FarmPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex;
  bool _showMode_card = true;
  TabController _tabController;
  // 子页面标题：
  List<Tab> _tabs;
  // 子页面：
  List<Widget> _tabPages;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _tabs = <Tab>[
      Tab(text: "种植"),
      Tab(text: "灌溉"),
    ];
    _tabPages = [
      new PlantTabPage(),
      new WaterTabPage(),
    ];
    // controller 初始化
    _tabController = new TabController(
      initialIndex: _currentIndex,
      length: _tabs.length,
      vsync: this,
    );
    // 为 controller 添加监听
    _tabController.addListener(_onTabChanged);
  }

  // 监听 tab
  _onTabChanged() {
    // 按一次 tab 会触发两次 监听方法，两次的 _tabController.animation.value 值不同
    // 一次是 开始位置，一次是 结束位置
    // print("===============");
    // print("${_tabController.index}  ${_tabController.animation.value}");
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      this.setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar_leading = new IconButton(
      icon: new Icon(_showMode_card == true ? Icons.dehaze : Icons.apps),
      onPressed: () {
        setState(() {
          _showMode_card = !_showMode_card;
        });
      },
    );

    Widget appBar_title = new TabBar(
      controller: _tabController,
      // isScrollable: false, // 不可滚动
      // labelPadding: new EdgeInsets.all(30),
      indicatorSize: TabBarIndicatorSize.tab, // 指示器和 tab 等宽
      indicatorColor: Colors.white,
      tabs: _tabs,
    );

    List<List<Widget>> appBar_actions = [
      [
        new IconButton(
            icon: new Icon(Icons.add_circle_outline), onPressed: () {}),
        new IconButton(icon: new Icon(Icons.delete_outline), onPressed: () {}),
      ],
      [
        new IconButton(icon: new Icon(null), onPressed: () {}),
        new IconButton(icon: new Icon(Icons.ac_unit), onPressed: () {}),
      ],
    ];

    return new StoreBuilder<MyState>(builder: (context, store) {
      return new Scaffold(
        appBar: new AppBar(
          leading: appBar_leading,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: appBar_title,
          centerTitle: true,
          actions: appBar_actions[_currentIndex],
        ),
        body: new TabBarView(
          controller: _tabController,
          children: _tabPages,
          physics: new NeverScrollableScrollPhysics(),
        ),
      );
    });
  }
}
