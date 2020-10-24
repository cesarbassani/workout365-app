import 'package:json_annotation/json_annotation.dart';

part 'treino_free_model.g.dart';

@JsonSerializable()
class TreinoFreeModel {
  int id;
  String nome;
  String descricao;
  String categoria;
  String tipo;
  String sexo;
  String preco;
  int ativo;
  int disponivel_store;
  String tempo_treino;

  TreinoFreeModel({
    this.id,
    this.nome,
    this.descricao,
    this.categoria,
    this.tipo,
    this.sexo,
    this.preco,
    this.ativo,
    this.disponivel_store,
    this.tempo_treino,
  });

  factory TreinoFreeModel.fromJson(Map<String, dynamic> json) =>
      _$TreinoFreeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreinoFreeModelToJson(this);
}
