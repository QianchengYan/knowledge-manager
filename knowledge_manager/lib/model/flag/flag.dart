import 'package:json_annotation/json_annotation.dart';

part 'flag.g.dart';

@JsonSerializable()
class Flag {
  Flag(
    this.id,
    this.title,
    this.description,
    this.finishedTime,
    this.note,
    this.flagContainer_id,
  );

  int id;
  String title;
  String description;
  String finishedTime;
  String note;
  int flagContainer_id;

  Map<String, dynamic> toJson() => _$FlagToJson(this);
  factory Flag.fromJson(Map<String, dynamic> json) => _$FlagFromJson(json);

  // 命名构造函数
  Flag.empty();
}