// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flag _$FlagFromJson(Map<String, dynamic> json) {
  return Flag(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['finishedTime'] as String,
    json['note'] as String,
    json['flagContainer_id'] as int,
  );
}

Map<String, dynamic> _$FlagToJson(Flag instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'finishedTime': instance.finishedTime,
      'note': instance.note,
      'flagContainer_id': instance.flagContainer_id,
    };
