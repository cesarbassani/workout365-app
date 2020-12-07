import 'package:json_annotation/json_annotation.dart';

part 'exercicio_conjugado_model.g.dart';

@JsonSerializable()
class ExercicioConjugadoModel {
  int id;
  int exercicio_treino_id;
  int exercicio_treino_conjugado_id;

  ExercicioConjugadoModel({
    this.id,
    this.exercicio_treino_id,
    this.exercicio_treino_conjugado_id,
  });

  factory ExercicioConjugadoModel.fromJson(Map<String, dynamic> json) =>
      _$ExercicioConjugadoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExercicioConjugadoModelToJson(this);
}
