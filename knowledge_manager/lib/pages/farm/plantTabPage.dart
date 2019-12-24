import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/model/farm/subject.dart';
import 'package:knowledge_manager/pages/farm/widget/my_subject_card.dart';

class PlantTabPage extends StatefulWidget {
  @override
  _PlantTabPageState createState() => _PlantTabPageState();
}

class _PlantTabPageState extends State<PlantTabPage> {
  List<Subject> subjectList = [
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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: subjectList.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
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
    // return Test(
    //   "通信原理",
    //   descript: "世间真理世间真理世间真理世间真理世间真理世间真理世间真理世间真理世间真理世间真理世间真理世间真理世间真理世间真理",
    //   plantValue: 30,
    //   waterValue: 50,
    // );
  }
}
