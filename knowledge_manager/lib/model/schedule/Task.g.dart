// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    json['id'] as int,
    json['imageUrl'] as String,
    json['title'] as String,
    json['description'] as String,
    json['startTime'] as String,
    json['endTime'] as String,
    json['status'] as int,
    json['note'] as String,
    json['user_username'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'description': instance.description,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
      'note': instance.note,
      'user_username': instance.user_username,
    };
