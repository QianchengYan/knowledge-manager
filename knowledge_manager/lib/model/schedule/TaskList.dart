// import 'package:json_annotation/json_annotation.dart';

// part 'TaskList.g.dart';

// @JsonSerializable()
// class TaskList {
//   TaskList(
//     this.id,
//     this.imageUrl,
//     this.title,
//     this.description,
//     this.startTime,
//     this.endTime,
//     this.status,
//     this.note,
//     this.user_username,
//   );

//   int id;
//   String imageUrl;
//   String title;
//   String description;
//   String startTime;
//   String endTime;
//   int status;
//   String note;
//   String user_username;

//   Map<String, dynamic> toJson() => _$TaskListToJson(this);
//   factory TaskList.fromJson(Map<String, dynamic> json) => _$TaskListFromJson(json);

//   // 命名构造函数
//   TaskList.empty();
// }