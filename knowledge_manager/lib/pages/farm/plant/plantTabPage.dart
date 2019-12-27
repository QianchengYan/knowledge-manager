import 'package:flutter/material.dart';
import 'package:knowledge_manager/common/style/my_images.dart';
import 'package:knowledge_manager/model/farm/subject.dart';
import 'package:knowledge_manager/model/farm/subject_group.dart';
import 'package:knowledge_manager/pages/farm/plant/subject_group_page.dart';
import 'package:knowledge_manager/pages/farm/plant/subject_page.dart';
import 'package:knowledge_manager/pages/farm/widget/my_subject_card.dart';

class PlantTabPage extends StatefulWidget {
  @override
  _PlantTabPageState createState() => _PlantTabPageState();
}

class _PlantTabPageState extends State<PlantTabPage> {
  List<Subject> subjectList;
  @override
  void initState() {
    print("=======================");
    super.initState();
  }

  @override
  void dispose() {
    print("=======================");
    print("plantTabPage.dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubjectPage();
  }
}
