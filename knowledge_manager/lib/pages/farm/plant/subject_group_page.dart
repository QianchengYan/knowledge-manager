import 'package:flutter/material.dart';

class SubjectGroupPage extends StatefulWidget {
  @override
  _SubjectGroupPageState createState() => _SubjectGroupPageState();
}

List listData = [
  {
    "id": 1,
    "name": 'first',
    "imageUrl": 'http://img1.izaoxing.com/allimg/c190122/154Q51262OG0-c029.jpg',
    "description": 'the beautiful'
  },
  {
    "id": 2,
    "name": 'first',
    "imageUrl": 'http://img1.izaoxing.com/allimg/c190122/154Q51262OG0-c029.jpg',
    "description": 'the beautiful'
  },
];

class _SubjectGroupPageState extends State<SubjectGroupPage> {

  @override
  initState() {
    
  }

  // 单击分组
  _onSubjectGroupTap(value) {

  }
  // 双击分组
  _onSubjectGroupDoubleTap(value) {
    
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listData.map((value) {
        // TODO:list.map如何获取
        return GestureDetector(
          // TODO:ontap 如何传参
          onTap: () {_onSubjectGroupTap(value);},
          onDoubleTap: () {_onSubjectGroupDoubleTap(value);} ,
          child: Card(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      value["imageUrl"],
                      fit: BoxFit.fill,
                    ),
                  ),
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(value["imageUrl"]),
                      ),
                      title: Text(value["name"]),
                      subtitle: Text(value["description"]))
                ],
              )),
        );
      }).toList(), //注意这里要转换成列表，因为listView只接受列表
    );
  }
}
