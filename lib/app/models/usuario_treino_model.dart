import 'package:json_annotation/json_annotation.dart';
import 'package:workout365app/app/models/feedback_model.dart';

part 'usuario_treino_model.g.dart';

@JsonSerializable()
class UsuarioTreinoModel {
  int id;
  int user_id;
  int treino_id;
  String data_inicio;
  String data_fim;
  String status_execucao;
  String tempo_execucao;
  FeedbackModel feedback;

  UsuarioTreinoModel({
    this.id,
    this.user_id,
    this.treino_id,
    this.data_inicio,
    this.data_fim,
    this.status_execucao,
    this.tempo_execucao,
    this.feedback,
  });

  factory UsuarioTreinoModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioTreinoModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioTreinoModelToJson(this);
}
