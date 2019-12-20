import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  User(
    this.login,
    this.id,
    this.avatar_url,
    this.name,
    this.email,
  );

  String login;
  int id;
  String avatar_url;
  String name;
  String email;

  Map<String, dynamic> toJson() => _$UserToJson(this);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // 命名构造函数
  User.empty();
}
