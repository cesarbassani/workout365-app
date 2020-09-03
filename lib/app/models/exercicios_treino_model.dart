import 'package:json_annotation/json_annotation.dart';
import 'package:workout365app/app/models/exercicio_model.dart';
import 'package:workout365app/app/models/serie_model.dart';

part 'exercicios_treino_model.g.dart';

@JsonSerializable()
class ExerciciosTreinoModel {
  int id;
  int exercicioId;
  int treinoId;
  int formaExecucaoId;
  String metodoTreino;
  String tempoExecucaoPorSerie;
  String tempoDescandoEntreSeries;
  String tempoDescandoProximoExercicio;
  int tempoTotalPorExercicio;
  int numeroSeries;
  ExercicioModel exercicio;
  List<SerieModel> series;

  ExerciciosTreinoModel(
      {this.id,
      this.exercicioId,
      this.treinoId,
      this.formaExecucaoId,
      this.metodoTreino,
      this.tempoExecucaoPorSerie,
      this.tempoDescandoEntreSeries,
      this.tempoDescandoProximoExercicio,
      this.tempoTotalPorExercicio,
      this.numeroSeries,
      this.exercicio,
      this.series});

  factory ExerciciosTreinoModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciciosTreinoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciciosTreinoModelToJson(this);
}
