import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject {
  Subject(
    this.id,
    this.name,
    this.description,
    this.accumulatedTime,
    this.memoryValue,
    this.groupId,
  );

  int id;
  String name;
  String description;
  DateTime accumulatedTime;
  int memoryValue;
  int groupId;

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);

  // 命名构造函数
  Subject.empty();
}