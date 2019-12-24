// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeNode _$KnowledgeNodeFromJson(Map<String, dynamic> json) {
  return KnowledgeNode(
    json['id'] as int,
    json['name'] as String,
    json['content'] as String,
    json['level'] as int,
    json['parentId'] as int,
    json['childId'] as int,
    json['lectureId'] as int,
  );
}

Map<String, dynamic> _$KnowledgeNodeToJson(KnowledgeNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'level': instance.level,
      'parentId': instance.parentId,
      'childId': instance.childId,
      'lectureId': instance.lectureId,
    };
