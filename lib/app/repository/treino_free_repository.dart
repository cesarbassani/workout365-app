import 'package:dio/dio.dart';
import 'package:workout365app/app/core/dio/custom_dio.dart';
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
}
