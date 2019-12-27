import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knowledge_manager/common/config/config.dart';
import 'package:knowledge_manager/dao/dao_utils.dart';
import 'package:knowledge_manager/dao/flag/flag_container_dao.dart';
import 'package:knowledge_manager/pages/flag/widget/flag_container_card.dart';
import 'package:knowledge_manager/redux/my_state.dart';

class FlagPage extends StatefulWidget {
  static final String routeName = "flag";

  @override
  _FlagPageState createState() => _FlagPageState();
}

class _FlagPageState extends State<FlagPage> {
  List<Map<String, dynamic>> _flagContainerList = [];
  var store;
  @override
  void initState() {
    print("=======================");
    print("FlagPage.initState()");
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (Config.DEBUG) {
      print("================SchedulePage.didChangeDependencies()");
    }
    store = StoreProvider.of<MyState>(context);
    String username = store.state.userInfo.username;
    DaoResult daoResult = await FlagContainerDao.get(username);

    daoResult.data["data"].forEach((value) {
      _flagContainerList.add(value);
    });
    setState(() {});
    print(_flagContainerList);
  }

  //   @override
  // didChangeDependencies() async {
  //   if (Config.DEBUG) {
  //     print("================SchedulePage.didChangeDependencies()");
  //   }
  //   store = StoreProvider.of<MyState>(context);
  //   DaoResult daoResult = await TaskDao.get(store);
  //   daoResult.data["data"].forEach((value) {
  //     _flagContainerList.add(value);
  //   });
  //   setState(() {});
  //   print(_flagContainerList);
  // }

  @override
  void dispose() {
    print("=======================");
    print("FlagPage.dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _flagContainerList == []
        ? Container(
            child: Text("没有flag~ 请添加"),
          )
        : GridView.builder(
            shrinkWrap: true,
            itemCount: _flagContainerList.length,
            physics: BouncingScrollPhysics(), // 內容超过一屏有，上拉有回弹效果
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 15,
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) {
              var item = _flagContainerList[index];
              return FlagContainerCard(item["title"], item["description"],
                  item["startTime"], item["totalDays"], item["finishedDays"]);
            },
          );
  }
}

/**
   * 网格视图，每个网格是一个“学科卡片”
   */
//   Widget getGridView(BuildContext context) {
//      GridView.builder(
//       shrinkWrap: true,
//       itemCount: _flagContainerList.length,
//       physics: BouncingScrollPhysics(), // 內容超过一屏有，上拉有回弹效果
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 15,
//         childAspectRatio: 1.8,
//       ),
//       itemBuilder: (context, index) {
//         var item = _flagContainerList[index];
//         return FlagContainerCard(
//           item["title"],
//           item["description"],
//           item["startTime"],
//           item["totalDays"],
//           item["finishedDays"]
//         );
//       },
//     );
//   }
// }
