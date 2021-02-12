import 'package:json_annotation/json_annotation.dart';

part 'imagem_exercicio_model.g.dart';

@JsonSerializable()
class ImagemExercicioModel {
  int id;
  int exercicioId;
  String imagem;
  String imagemMiniatura;
  int ordem;

  ImagemExercicioModel(
      {this.id,
      this.exercicioId,
      this.imagem,
      this.imagemMiniatura,
      this.ordem});

  factory ImagemExercicioModel.fromJson(Map<String, dynamic> json) =>
      _$ImagemExercicioModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImagemExercicioModelToJson(this);
}
