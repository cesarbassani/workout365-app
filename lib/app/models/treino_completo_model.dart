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
  double preco;
  int ativo;
  int disponivelStore;
  String createdAt;
  String updatedAt;
  List<String> gruposMuculares;
  List<String> equipamentos;
  List<ExerciciosTreinoModel> exerciciosTreino;
  int quantidadeExerciciosTreino;
  int tempoTotalPorTreino;

  TreinoCompletoModel(
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
      this.updatedAt,
      this.gruposMuculares,
      this.equipamentos,
      this.exerciciosTreino,
      this.quantidadeExerciciosTreino,
      this.tempoTotalPorTreino});

  factory TreinoCompletoModel.fromJson(Map<String, dynamic> json) =>
      _$TreinoCompletoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreinoCompletoModelToJson(this);
}
