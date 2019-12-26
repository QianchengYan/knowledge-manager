import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/model/farm/subject.dart';
import 'package:knowledge_manager/pages/farm/widget/my_subject_card.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<Subject> subjectList;
  @override
  void initState() {
    print("=======================");
    print("SubjectPage.initState()");
    super.initState();
    subjectList = [
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "毛概", "毛泽东思想与中国特色社会主义概述", DateTime.now(), 20, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "毛概", "毛泽东思想与中国特色社会主义概述", DateTime.now(), 30, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "毛概", "毛泽东思想与中国特色社会主义概述", DateTime.now(), 40, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "毛概", "毛泽东思想与中国特色社会主义概述", DateTime.now(), 50, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "毛概", "毛泽东思想与中国特色社会主义概述", DateTime.now(), 10, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
      new Subject(1, "毛概", "毛泽东思想与中国特色社会主义概述", DateTime.now(), 10, 0),
      new Subject(1, "通原", "通信原理", DateTime.now(), 10, 0),
    ];
  }

  @override
  void dispose() {
    print("=======================");
    print("SubjectPage.dispose()");
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
      itemCount: subjectList.length,
      physics: BouncingScrollPhysics(), // 內容超过一屏有，上拉有回弹效果
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        var item = subjectList[index];
        return MySubjectCard(
          item.name,
          description: item.description,
          plantValue: item.accumulatedTime.minute,
          waterValue: item.memoryValue,
        );
      },
    );
  }
}
