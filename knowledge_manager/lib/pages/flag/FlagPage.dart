import 'package:flutter/material.dart';
import 'package:knowledge_manager/model/flag/flagContainer.dart';
import 'package:knowledge_manager/pages/flag/widget/flag_container_card.dart';

class FlagPage extends StatefulWidget {
  static final String routeName = "flag";

  @override
  _FlagPageState createState() => _FlagPageState();
}

class _FlagPageState extends State<FlagPage> {
  List<FlagContainer> FlagContainerList;
  @override
  void initState() {
    print("=======================");
    print("FlagPage.initState()");
    super.initState();
    FlagContainerList = [
      new FlagContainer(1, "早起", "早起身体好", DateTime.now().toString(), 21, 10),
      new FlagContainer(1, "早睡", "早睡身体好", DateTime.now().toString(), 21, 5),
      new FlagContainer(1, "俯卧撑", "一天50个", DateTime.now().toString(), 21, 18),
    ];
  }

  @override
  void dispose() {
    print("=======================");
    print("FlagPage.dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getGridView(context);
  }

  /**
   * 网格视图，每个网格是一个“学科卡片”
   */
  Widget getGridView(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: FlagContainerList.length,
      physics: BouncingScrollPhysics(), // 內容超过一屏有，上拉有回弹效果
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        var item = FlagContainerList[index];
        return FlagContainerCard(
          item.title,
          item.startTime,
          item.totalDays,
          item.finishedDays,
          description: item.description,
        );
      },
    );
  }
}
