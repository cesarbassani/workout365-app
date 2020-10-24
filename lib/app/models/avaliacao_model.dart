import 'package:json_annotation/json_annotation.dart';

part 'avaliacao_model.g.dart';

@JsonSerializable()
class AvaliacaoModel {
  int user_treino_id;
  String comentario;
  int nota;
  int id;

  AvaliacaoModel({
    this.user_treino_id,
    this.comentario,
    this.nota,
    this.id,
  });

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) =>
      _$AvaliacaoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvaliacaoModelToJson(this);
}
