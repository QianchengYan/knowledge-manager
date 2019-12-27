// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flagContainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlagContainer _$FlagContainerFromJson(Map<String, dynamic> json) {
  return FlagContainer(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['startTime'] as String,
    json['totalDays'] as int,
    json['finishedDays'] as int,
  );
}

Map<String, dynamic> _$FlagContainerToJson(FlagContainer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime,
      'totalDays': instance.totalDays,
      'finishedDays': instance.finishedDays,
    };
