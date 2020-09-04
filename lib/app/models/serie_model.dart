import 'package:json_annotation/json_annotation.dart';

part 'serie_model.g.dart';

@JsonSerializable()
class SerieModel {
  int id;
  int exercicio_treino_id;
  int repeticoes;
  int carga;
  String tempoPausa;

  SerieModel({
    this.id,
    this.exercicio_treino_id,
    this.repeticoes,
    this.carga,
    this.tempoPausa,
  });

  factory SerieModel.fromJson(Map<String, dynamic> json) =>
      _$SerieModelFromJson(json);
  Map<String, dynamic> toJson() => _$SerieModelToJson(this);
}
