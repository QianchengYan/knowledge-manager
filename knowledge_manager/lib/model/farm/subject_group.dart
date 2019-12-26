import 'package:json_annotation/json_annotation.dart';

part 'subject_group.g.dart';

@JsonSerializable()
class SubjectGroup {
  SubjectGroup(
    this.id,
    this.name,
    this.imageUrl,
    this.description,
  );

  int id;
  String name;
  String imageUrl;
  String description;

  Map<String, dynamic> toJson() => _$SubjectGroupToJson(this);
  factory SubjectGroup.fromJson(Map<String, dynamic> json) => _$SubjectGroupFromJson(json);

  // 命名构造函数
  SubjectGroup.empty();
}