import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Login {
  Login({required this.email, required this.password});

  final String email;
  final String password;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
