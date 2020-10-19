import 'package:json_annotation/json_annotation.dart';

part 'serie_model.g.dart';

@JsonSerializable()
class SerieModel {
  int id;
  int exercicio_treino_id;
  int repeticoes;
  int carga;
  String tempoPausa;
  int sequencia_sub_serie;

  SerieModel(
      {this.id,
      this.exercicio_treino_id,
      this.repeticoes,
      this.carga,
      this.tempoPausa,
      this.sequencia_sub_serie});

  factory SerieModel.fromJson(Map<String, dynamic> json) =>
      _$SerieModelFromJson(json);
  Map<String, dynamic> toJson() => _$SerieModelToJson(this);
}
