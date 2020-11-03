import 'package:json_annotation/json_annotation.dart';
import 'package:workout365app/app/models/exercicio_model.dart';
import 'package:workout365app/app/models/forma_execucao_model.dart';
import 'package:workout365app/app/models/serie_model.dart';

part 'exercicios_treino_model.g.dart';

@JsonSerializable()
class ExerciciosTreinoModel {
  int id;
  int exercicio_id;
  int treino_id;
  FormaExecucaoModel forma_execucao;
  String metodo_treino;
  int tempo_execucao_por_serie;
  int tempo_descando_entre_series;
  int tempo_descando_proximo_exercicio;
  int tempo_total_por_exercicio;
  int numero_series;
  ExercicioModel exercicio;
  List<SerieModel> series;
  int ordem;
  int num_sub_series;

  ExerciciosTreinoModel(
      {this.id,
      this.exercicio_id,
      this.treino_id,
      this.forma_execucao,
      this.metodo_treino,
      this.tempo_execucao_por_serie,
      this.tempo_descando_entre_series,
      this.tempo_descando_proximo_exercicio,
      this.tempo_total_por_exercicio,
      this.numero_series,
      this.exercicio,
      this.series,
      this.ordem,
      this.num_sub_series});

  factory ExerciciosTreinoModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciciosTreinoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciciosTreinoModelToJson(this);
}
