import 'package:json_annotation/json_annotation.dart';

part 'categoria_exercicio_model.g.dart';

@JsonSerializable()
class CategoriaExercicioModel {
  int id;
  String descricao;

  CategoriaExercicioModel({
    this.id,
    this.descricao,
  });

  factory CategoriaExercicioModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriaExercicioModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriaExercicioModelToJson(this);
}
