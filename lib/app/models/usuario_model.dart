import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {
  int id;
  String nome;
  String data_nascimento;
  String email;
  String cpf;
  String cep;
  double peso;
  double altura;
  String telefone;
  int gestor;
  int tempo_treino;

  UsuarioModel({
    this.id,
    this.nome,
    this.data_nascimento,
    this.email,
    this.cpf,
    this.cep,
    this.peso,
    this.altura,
    this.telefone,
    this.gestor,
    this.tempo_treino,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
