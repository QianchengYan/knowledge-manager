import 'package:json_annotation/json_annotation.dart';

part 'knowledge_node.g.dart';

@JsonSerializable()
class KnowledgeNode {
  KnowledgeNode(
    this.id,
    this.name,
    this.content,
    this.level,
    this.parentId,
    this.childId,
    this.lectureId,
  );

  int id;
  String name;
  String content;
  int level;
  int parentId;
  int childId;
  int lectureId;

  Map<String, dynamic> toJson() => _$KnowledgeNodeToJson(this);
  factory KnowledgeNode.fromJson(Map<String, dynamic> json) => _$KnowledgeNodeFromJson(json);

  // 命名构造函数
  KnowledgeNode.empty();
}