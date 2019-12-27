import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/dao/dao_utils.dart';
import 'package:knowledge_manager/dao/schedule/task_dao.dart';
import 'package:knowledge_manager/dao/user_dao.dart';
import 'package:knowledge_manager/redux/my_state.dart';

class WorldPage extends StatefulWidget {
  static final String routeName = "world";

  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  List<Map<String, dynamic>> _listBody = [];
  var store;
  @override
  initState() {
    super.initState();
    if (Config.DEBUG) {
      print("================WorldPage.initState()");
    }
  }

  @override
  didChangeDependencies() async {
    if (Config.DEBUG) {
      print("================WorldPage.didChangeDependencies()");
    }
    DaoResult daoResult = await UserDao.getAllUserInfo();
    daoResult.data["data"].forEach((value) {
      _listBody.add(value);
    });
    setState(() {});
    print(_listBody);
  }

  // 单击分组
  _onSubjectGroupTap(value) {}
  // 双击分组
  _onSubjectGroupDoubleTap(value) {}
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _listBody.map((value) {
        // TODO:list.map如何获取
        return GestureDetector(
          // TODO:ontap 如何传参
          onTap: () {
            _onSubjectGroupTap(value);
          },
          onDoubleTap: () {
            _onSubjectGroupDoubleTap(value);
          },
          child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(MyImages.DEFAULT_USER_AVATAR),
                  ),
                  title: Text(value["name"]??"没有昵称哦"),
                  subtitle: Text("没有签名哦~"))),
        );
      }).toList(), //注意这里要转换成列表，因为listView只接受列表
    );
  }
}
