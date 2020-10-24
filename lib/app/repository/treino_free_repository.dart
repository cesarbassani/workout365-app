import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/core/dio/custom_dio.dart';
import 'package:workout365app/app/models/avaliacao_model.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/models/usuario_treino_model.dart';
import 'package:workout365app/app/shared/auth_store.dart';

class TreinoFreeRepository {
  Future<List<TreinoFreeModel>> listarTreinosFree() async {
    try {
      var response = await CustomDio.authInstance.get('/treinos/gratuitos',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          }));
      print(response.data['data']);
      return (response.data['data'] as List)
          .map((item) => TreinoFreeModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<List<TreinoCompletoModel>> buscarTreinoCompleto(int treinoId) async {
    try {
      var response =
          await CustomDio.authInstance.get('/treinos/completo/$treinoId',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              }));

      print(response.data['data']);
      return (response.data['data'] as List)
          .map((item) => TreinoCompletoModel.fromJson(item))
          .toList();
//      var data = TreinoCompletoModel.fromJson(response.data['data']);
//      return data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<UsuarioTreinoModel> enviarInicioTreino(
      TreinoCompletoModel treinoCompleto, String inicioDoTreino) async {
    try {
      var response = await CustomDio.authInstance.post('/usuariostreinos',
          data: {
            "user_id": Modular.get<AuthStore>().usuarioLogado.id,
            "treino_id": treinoCompleto.id,
            "data_inicio": inicioDoTreino,
            "status_execucao": "em_execucao",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          }));

      print(response.data['data']);
      var data = UsuarioTreinoModel.fromJson(response.data['data']);

      return data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<UsuarioTreinoModel> enviarFimDoTreino(
      UsuarioTreinoModel usuarioTreinoModel,
      String datafimTreino,
      String tempoTotalTreino) async {
    try {
      return await CustomDio.authInstance
          .put('/usuariostreinos',
              data: {
                "id": usuarioTreinoModel.id,
                "user_id": Modular.get<AuthStore>().usuarioLogado.id,
                "treino_id": usuarioTreinoModel.treino_id,
                "data_fim": datafimTreino,
                "status_execucao": "finalizado",
                "tempo_execucao": tempoTotalTreino,
              },
              options: Options(headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              }))
          .then((res) => UsuarioTreinoModel.fromJson(res.data['data']));
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<AvaliacaoModel> enviarAvaliacao(int userTreinoId, int nota) async {
    try {
      return await CustomDio.authInstance
          .post('/avaliacoes',
              data: {
                "user_treino_id": userTreinoId,
                "nota": nota,
              },
              options: Options(headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              }))
          .then((res) => AvaliacaoModel.fromJson(res.data['data']));
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
