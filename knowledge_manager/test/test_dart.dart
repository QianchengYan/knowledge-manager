// import 'package:flutter/material.dart';
void main(List<String> args) {
  //   int _currentIndex = 0;
  const List<String> titles = [
    "日程",
    "Flag",
    "",
    "任务",
    "世界",
  ];
  // const List<IconData> icons = [
  //   Icons.home,
  //   Icons.flag,
  //   Icons.fiber_manual_record,
  //   Icons.tab,
  //   Icons.work,
  // ];
  List<dynamic> bottomItems = (() {
    List<dynamic> list = List();
    for (var i = 0; i < titles.length; i++) {
      list.add(titles[i]
      );
    }
    return list;
  })();

  print(bottomItems);
}