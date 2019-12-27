import 'package:json_annotation/json_annotation.dart';

part 'flagContainer.g.dart';

@JsonSerializable()
class FlagContainer {
  FlagContainer(
    this.id,
    this.title,
    this.description,
    this.startTime,
    this.totalDays,
    this.finishedDays,
  );

  int id;
  String title;
  String description;
  String startTime;
  int totalDays;
  int finishedDays;

  Map<String, dynamic> toJson() => _$FlagContainerToJson(this);
  factory FlagContainer.fromJson(Map<String, dynamic> json) => _$FlagContainerFromJson(json);

  // 命名构造函数
  FlagContainer.empty();
}