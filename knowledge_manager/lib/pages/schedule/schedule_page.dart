import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/net/address.dart';
import 'package:knowledge_manager/dao/user_dao.dart';
import 'package:knowledge_manager/redux/my_state.dart';

class SchedulePage extends StatefulWidget {
  static final String routeName = "farm";

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // 标题：appBar 和 bottomItem 用到
  static const List<String> titles = [
    "日程",
    "Flag",
    "任务",
    "世界",
  ];
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MyState>(
      builder: (context, store) {
        return Column(
          children: <Widget>[
            FlatButton(
              child: Text("测试"),
              onPressed: () async {
                print(store.state.locale);
                UserDao.getUserInfo("1", store, isMy: true);
                // var dio = new Dio();
                // var response =
                //     await dio.get(Address.getMyInfo(), queryParameters: {"username": 1});
                // print(response.data.toString());
              },
            ),
          ],
        );
      },
    );
  }
}
