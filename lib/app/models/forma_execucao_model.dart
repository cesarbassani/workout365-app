import 'package:json_annotation/json_annotation.dart';

part 'forma_execucao_model.g.dart';

@JsonSerializable()
class FormaExecucaoModel {
  int id;
  String descricao;

  FormaExecucaoModel({
    this.id,
    this.descricao,
  });

  factory FormaExecucaoModel.fromJson(Map<String, dynamic> json) =>
      _$FormaExecucaoModelFromJson(json);
  Map<String, dynamic> toJson() => _$FormaExecucaoModelToJson(this);
}
