import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  User(
    this.id,
    this.username,
    this.name,
    this.avatarUrl,
    this.phone,
    this.email,
  );

  int id;
  String username;
  String name;
  String avatarUrl;
  String phone;
  String email;

  Map<String, dynamic> toJson() => _$UserToJson(this);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // 命名构造函数
  User.empty();
}
