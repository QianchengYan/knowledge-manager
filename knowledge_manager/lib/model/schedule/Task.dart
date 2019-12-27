import 'package:json_annotation/json_annotation.dart';

part 'Task.g.dart';

@JsonSerializable()
class Task {
  Task(
    this.id,
    this.imageUrl,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.status,
    this.note,
    this.user_username,
  );

  int id;
  String imageUrl;
  String title;
  String description;
  String startTime;
  String endTime;
  int status;
  String note;
  String user_username;

  Map<String, dynamic> toJson() => _$TaskToJson(this);
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  // 命名构造函数
  Task.empty();
}
