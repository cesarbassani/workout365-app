import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {
  String id;
  String nome;
  String cpf;
  String email;
  String sexo;
  String telefone;
  String password;
  String passwordConfirmation;

  UsuarioModel(
      {this.nome,
      this.cpf,
      this.email,
      this.sexo,
      this.telefone,
      this.password,
      this.passwordConfirmation});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
