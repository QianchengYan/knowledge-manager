import 'package:json_annotation/json_annotation.dart';

part 'lecture.g.dart';

@JsonSerializable()
class Lecture {
  Lecture(
    this.id,
    this.name,
    this.description,
    this.accumulatedTime,
    this.memoryValue,
    this.subjectId,
  );

  int id;
  String name;
  String description;
  DateTime accumulatedTime;
  int memoryValue;
  int subjectId;

  Map<String, dynamic> toJson() => _$LectureToJson(this);
  factory Lecture.fromJson(Map<String, dynamic> json) => _$LectureFromJson(json);

  // 命名构造函数
  Lecture.empty();
}