import 'package:json_annotation/json_annotation.dart';

part 'leaning_recode.g.dart';

@JsonSerializable()
class LeaningRecord {
  LeaningRecord(
    this.id,
    this.startTime,
    this.endTime,
    this.accumulatedTime,
    this.note,
    this.lectureId,
  );

  int id;
  DateTime startTime;
  DateTime endTime;
  DateTime accumulatedTime;
  String note;
  int lectureId;

  Map<String, dynamic> toJson() => _$LeaningRecordToJson(this);
  factory LeaningRecord.fromJson(Map<String, dynamic> json) => _$LeaningRecordFromJson(json);

  // 命名构造函数
  LeaningRecord.empty();
}