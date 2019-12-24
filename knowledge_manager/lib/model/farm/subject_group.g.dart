// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectGroup _$SubjectGroupFromJson(Map<String, dynamic> json) {
  return SubjectGroup(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$SubjectGroupToJson(SubjectGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
