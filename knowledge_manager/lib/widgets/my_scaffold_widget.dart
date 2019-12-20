import 'package:flutter/material.dart';

// 定义枚举类型，规定TabBar的模式
enum TabType { top, bottom }

/**
 * 支持顶部底部的TabBar控件
 * 配合AutomaticKeepAliveClientMixin可以keep住
 */
class MyScaffoldWidget extends StatefulWidget {
  final TabType type; // TabBar类型
  final bool resizeToAvoidBottomPadding;
  final List<Widget> tabItems;
  final List<Widget> tabPages;
  final Color backgroundColor; // 背景颜色
  final Color indicatorColor; // 选中颜色
  final Widget title;
  final Widget drawer; // 侧边拉窗
  final Widget floatingActionButton; // 浮动按钮
  final FloatingActionButtonLocation floatingActionButtonLocation; // 浮动按钮位置
  final Widget bottomBar; //
  final List<Widget> footerButtons;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onDoublePress;
  final ValueChanged<int> onSinglePress;

  MyScaffoldWidget({
    Key key,
    this.type = TabType.top,
    this.resizeToAvoidBottomPadding,
    this.tabItems,
    this.tabPages,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomBar,
    this.footerButtons,
    this.onPageChanged,
    this.onDoublePress,
    this.onSinglePress,
  }) : super(key: key);

  @override
  _MyScaffoldWidgetState createState() => _MyScaffoldWidgetState();
}

class _MyScaffoldWidgetState extends State<MyScaffoldWidget> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: widget.tabItems.length);
  }

  // 当整个页面dispose的时候，控制器也要dispose，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 总共两个事件，一个是pageChange一个是tabClick
  _navigationPageChanged(index) {
    if(index == _currentIndex) {
      return;
    }
    _currentIndex = index;
    _tabController.animateTo(index);
    widget.onPageChanged?.call(index);
  }

  _navigationTabTap(index) {
    if(index == _currentIndex) {
      return;
    }
    _currentIndex = index;
    widget.onPageChanged?.call(index);
    // 不想要动画
    _pageController.jumpTo(MediaQuery.of(context).size.width * index);
    widget.onSinglePress?.call(index);
  }

  _navigationDoubleTabTap(index) {
    _navigationTabTap(index);
    widget.onDoublePress?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == TabType.top) {
      return new Scaffold(
        resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
        floatingActionButton:
            SafeArea(child: widget.floatingActionButton ?? Container()),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons: widget.footerButtons,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          bottom: new TabBar(
            controller: _tabController, // 事件处理
            tabs: widget.tabItems,
            indicatorColor: widget.indicatorColor,
            onTap: _navigationTabTap, // 事件处理
          ),
        ),
        body: new PageView(
          controller: _pageController, // 事件处理
          children: widget.tabPages,
          onPageChanged: _navigationPageChanged, // 事件处理
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    } else {
      return new Scaffold(
        drawer: widget.drawer,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
        ),
        body: new PageView(
          controller: _pageController,
          children: widget.tabPages,
          onPageChanged: _navigationPageChanged,
        ),
        bottomNavigationBar: new Material(
          //为了适配主题风格，包一层Material实现风格套用
          color: Theme.of(context).primaryColor, //底部导航栏主题颜色
          child: new SafeArea(
            child: new TabBar(
              //TabBar导航标签，底部导航放到Scaffold的bottomNavigationBar中
              controller: _tabController,
              //配置控制器
              tabs: widget.tabItems,
              indicatorColor: widget.indicatorColor,
              onTap: _navigationTabTap, //tab标签的下划线颜色
            ),
          ),
        )
      );
    }
  }
}