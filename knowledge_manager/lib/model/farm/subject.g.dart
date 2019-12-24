// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['accumulatedTime'] == null
        ? null
        : DateTime.parse(json['accumulatedTime'] as String),
    json['memoryValue'] as int,
    json['groupId'] as int,
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'accumulatedTime': instance.accumulatedTime?.toIso8601String(),
      'memoryValue': instance.memoryValue,
      'groupId': instance.groupId,
    };
