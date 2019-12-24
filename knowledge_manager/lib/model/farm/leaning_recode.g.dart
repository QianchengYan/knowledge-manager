// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaning_recode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaningRecord _$LeaningRecordFromJson(Map<String, dynamic> json) {
  return LeaningRecord(
    json['id'] as int,
    json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    json['endTime'] == null ? null : DateTime.parse(json['endTime'] as String),
    json['accumulatedTime'] == null
        ? null
        : DateTime.parse(json['accumulatedTime'] as String),
    json['note'] as String,
    json['lectureId'] as int,
  );
}

Map<String, dynamic> _$LeaningRecordToJson(LeaningRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'accumulatedTime': instance.accumulatedTime?.toIso8601String(),
      'note': instance.note,
      'lectureId': instance.lectureId,
    };
