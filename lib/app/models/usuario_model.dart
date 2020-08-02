import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {
  int id;
  String nome;
  String dataNascimento;
  String email;
  String cpf;
  String cep;
  double peso;
  double altura;
  String telefone;
  int gestor;
  int tempoTreino;

  UsuarioModel({
    this.id,
    this.nome,
    this.dataNascimento,
    this.email,
    this.cpf,
    this.cep,
    this.peso,
    this.altura,
    this.telefone,
    this.gestor,
    this.tempoTreino,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
