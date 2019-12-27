import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/dao/dao_utils.dart';
import 'package:knowledge_manager/dao/flag/flag_container_dao.dart';
import 'package:knowledge_manager/redux/my_state.dart';

class ContactPage extends StatefulWidget {
  static final String routeName = "task";

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MyState>(builder: (context, store) {
      return Column(
        children: <Widget>[
          FlatButton(
            child: Text("测试"),
            onPressed: () async {
              print(store.state.locale);
              DaoResult daoResult = await FlagContainerDao.get(store);
              print("===========测试结果${daoResult.data["data"]}");
              print("===========测试结果${daoResult.data["data"]}");
              List<Map<String, dynamic>> list = daoResult.data["data"];
              print(list);
              // var dio = new Dio();
              // var response =
              //     await dio.get(Address.getMyInfo(), queryParameters: {"username": 1});
              // print(response.data.toString());
            },
          ),
        ],
      );
    });
  }
}
