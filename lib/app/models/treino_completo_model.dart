import 'package:json_annotation/json_annotation.dart';

import 'exercicios_treino_model.dart';

part 'treino_completo_model.g.dart';

@JsonSerializable()
class TreinoCompletoModel {
  int id;
  String nome;
  String descricao;
  String categoria;
  String tipo;
  String sexo;
  String preco;
  int ativo;
  int disponivel_store;
  List<String> grupos_muculares;
  List<String> equipamentos;
  List<ExerciciosTreinoModel> exercicios_treino;
  int quantidade_exercicios_treino;
  String tempo_total_por_treino;

  TreinoCompletoModel(
      {this.id,
      this.nome,
      this.descricao,
      this.categoria,
      this.tipo,
      this.sexo,
      this.preco,
      this.ativo,
      this.disponivel_store,
      this.grupos_muculares,
      this.equipamentos,
      this.exercicios_treino,
      this.quantidade_exercicios_treino,
      this.tempo_total_por_treino});

  factory TreinoCompletoModel.fromJson(Map<String, dynamic> json) =>
      _$TreinoCompletoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreinoCompletoModelToJson(this);
}
