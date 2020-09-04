import 'package:dio/dio.dart';
import 'package:workout365app/app/core/dio/custom_dio.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/treino_free_model.dart';

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
}
