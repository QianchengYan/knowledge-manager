// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return Lecture(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['accumulatedTime'] == null
        ? null
        : DateTime.parse(json['accumulatedTime'] as String),
    json['memoryValue'] as int,
    json['subjectId'] as int,
  );
}

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'accumulatedTime': instance.accumulatedTime?.toIso8601String(),
      'memoryValue': instance.memoryValue,
      'subjectId': instance.subjectId,
    };
