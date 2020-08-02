import 'package:json_annotation/json_annotation.dart';

part 'confirm_login_model.g.dart';

@JsonSerializable()
class ConfirmLoginModel {
  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'refresh_token')
  String refreshToken;

  ConfirmLoginModel({this.token, this.refreshToken});

  factory ConfirmLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmLoginModelToJson(this);
}
