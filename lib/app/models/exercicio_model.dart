import 'package:json_annotation/json_annotation.dart';
import 'package:workout365app/app/models/categoria_exercicio_model.dart';

part 'exercicio_model.g.dart';

@JsonSerializable()
class ExercicioModel {
  int id;
  int categoriaExercicioId;
  CategoriaExercicioModel categoriaExercicio;
  String nome;
  String descricao;
  String animacaoBase64;
  String video;

  ExercicioModel(
      {this.id,
      this.categoriaExercicioId,
      this.categoriaExercicio,
      this.nome,
      this.descricao,
      this.animacaoBase64,
      this.video});

  factory ExercicioModel.fromJson(Map<String, dynamic> json) =>
      _$ExercicioModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExercicioModelToJson(this);
}
