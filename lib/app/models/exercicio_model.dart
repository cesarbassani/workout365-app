import 'package:json_annotation/json_annotation.dart';
import 'package:workout365app/app/models/categoria_exercicio_model.dart';

part 'exercicio_model.g.dart';

@JsonSerializable()
class ExercicioModel {
  int id;
  int categoria_exercicio_id;
  CategoriaExercicioModel categoria_exercicio;
  String nome;
  String descricao;
  String video;
  List<String> grupos_musculares;

  ExercicioModel({
    this.id,
    this.categoria_exercicio_id,
    this.categoria_exercicio,
    this.nome,
    this.descricao,
    this.video,
    this.grupos_musculares,
  });

  factory ExercicioModel.fromJson(Map<String, dynamic> json) =>
      _$ExercicioModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExercicioModelToJson(this);
}
