import 'package:json_annotation/json_annotation.dart';

part 'categoria_exercicio_model.g.dart';

@JsonSerializable()
class CategoriaExercicioModel {
  int id;
  int exercicioTreinoId;
  int repeticoes;
  int carga;
  String tempoPausa;

  CategoriaExercicioModel({
    this.id,
    this.exercicioTreinoId,
    this.repeticoes,
    this.carga,
    this.tempoPausa,
  });

  factory CategoriaExercicioModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriaExercicioModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriaExercicioModelToJson(this);
}
