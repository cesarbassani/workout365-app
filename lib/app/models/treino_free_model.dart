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
  double preco;
  int ativo;
  int disponivelStore;
  String createdAt;
  String updatedAt;

  TreinoFreeModel(
      {this.id,
      this.nome,
      this.descricao,
      this.categoria,
      this.tipo,
      this.sexo,
      this.preco,
      this.ativo,
      this.disponivelStore,
      this.createdAt,
      this.updatedAt});

  factory TreinoFreeModel.fromJson(Map<String, dynamic> json) =>
      _$TreinoFreeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreinoFreeModelToJson(this);
}
