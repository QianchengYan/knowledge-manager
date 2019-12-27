import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
                DaoResult daoResult = await TaskDao.get(store);
                print("===========测试结果${daoResult.data["data"]}");
                print("===========测试结果${daoResult.data["data"][0].runtimeType}");
                List<dynamic> list = daoResult.data["data"];
                print(list);
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