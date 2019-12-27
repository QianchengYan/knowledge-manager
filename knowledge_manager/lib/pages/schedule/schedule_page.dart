import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/common/style/my_text_style.dart';
import 'package:knowledge_manager/dao/dao_utils.dart';
import 'package:knowledge_manager/dao/schedule/task_dao.dart';
import 'package:knowledge_manager/redux/my_state.dart';

class SchedulePage extends StatefulWidget {
  static final String routeName = "farm";

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, dynamic>> _expansionPanelList = [
    {
      "leading": Icons.content_paste,
      "color": Colors.blue,
      "title": "待完成",
      "status": 0,
      "isExpanded": true,
    },
    {
      "leading": Icons.done,
      "color": Colors.green,
      "title": "已完成",
      "status": 1,
      "isExpanded": true,
    },
    {
      "leading": Icons.block,
      "color": Colors.red,
      "title": "超时",
      "status": -1,
      "isExpanded": true,
    },
  ];
  static List<Map<String, dynamic>> _listBody2 = [
    {
      "index": 0,
      "title": "吃早饭",
      "description": "吃少吃少吃少吃少吃少吃少",
      "startTime": DateTime.now(),
      "endTime": DateTime.now(),
      "status": 0,
      "node": null
    },
    {
      "index": 1,
      "title": "吃午饭",
      "description": "吃饱吃饱吃饱吃饱吃饱吃饱",
      "startTime": DateTime.now(),
      "endTime": DateTime.now(),
      "status": 1,
      "node": null
    },
    {
      "index": 2,
      "title": "吃晚饭",
      "description": "吃好吃好吃好吃好吃好吃好",
      "startTime": DateTime.now(),
      "endTime": DateTime.now(),
      "status": -1,
      "node": null
    },
  ];
  List<Map<String, dynamic>> _listBody = [];
  var store;
  @override
  initState() {
    super.initState();
    if (Config.DEBUG) {
      print("================SchedulePage.initState()");
    }
  }

  @override
  didChangeDependencies() async {
    if (Config.DEBUG) {
      print("================SchedulePage.didChangeDependencies()");
    }
    store = StoreProvider.of<MyState>(context);
    DaoResult daoResult = await TaskDao.get(store);
    daoResult.data["data"].forEach((value) {
      _listBody.add(value);
    });
    setState(() {});
    print(_listBody);
  }

  @override
  dispose() {
    super.dispose();
    if (Config.DEBUG) {
      print("================SchedulePage.dispose()");
    }
  }

  // 单击分组
  _onSubjectGroupTap(value) {}
  // 双击分组
  _onSubjectGroupDoubleTap(value) {}
  @override
  Widget build(BuildContext context) {
    var _isExpanded = true;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ExpansionPanelList(
            expansionCallback: (index, bol) {
              setState(() {
                _expansionPanelList[index]["isExpanded"] =
                    !_expansionPanelList[index]["isExpanded"];
              });
            },
            animationDuration: kThemeAnimationDuration,

            // 收缩栏列表
            children: _expansionPanelList.map((panelListValue) {
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    leading: Icon(
                      panelListValue["leading"],
                      color: panelListValue["isExpanded"]
                          ? panelListValue["color"]
                          : null,
                    ),
                    title: Text(panelListValue["title"]),
                  );
                },
                isExpanded: panelListValue["isExpanded"],
                canTapOnHeader: true,
                body: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                    // 收缩栏里面的 item 列表
                    child: ListBody(
                        children: _listBody.length != 0
                            ? _listBody
                                .where((listBodyValue) =>
                                    listBodyValue["status"] ==
                                    panelListValue["status"])
                                .map((listBodyValue) {
                                return GestureDetector(
                                  onTap: () {
                                    _onSubjectGroupTap(listBodyValue);
                                  },
                                  onDoubleTap: () {
                                    _onSubjectGroupDoubleTap(listBodyValue);
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                MyImages.DEFAULT_USER_AVATAR),
                                          ),
                                          title: Text(
                                              listBodyValue["title"] ?? ""),
                                          subtitle: Text(
                                              listBodyValue["description"] ??
                                                  ""),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList() //注意这里要转换成列表，因为listView只接受列表
                            : <Widget>[
                                ListTile(
                                  title: Text(
                                    "Noting~",
                                    style: MyTextStyle.smallSubText,
                                  ),
                                ),
                              ])),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ListBody(
//                     children: <Widget>[
//                       Card(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text('我是内容'),
//                         ),
//                       ),
//                       Card(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text('我是内容'),
//                         ),
//                       ),
//                       Card(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text('我是内容'),
//                         ),
//                       ),
//                       Card(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text('我是内容'),
//                         ),
//                       ),
//                       Card(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Text('我是内容'),
//                         ),
//                       ),
//                     ],
//                   ),
