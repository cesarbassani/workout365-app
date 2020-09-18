import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:workout365app/app/repository/security_storage_repository.dart';
import 'package:workout365app/app/repository/shared_prefs_repository.dart';

import 'custom_dio.dart';

class AuthInterceptorWrapper extends InterceptorsWrapper {
  static const isProduction = bool.fromEnvironment('dart.vm.product');
  @override
  Future onRequest(RequestOptions options) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = 'bearer ${prefs.token}';
    if (DotEnv().env['profile'] == (isProduction ? 'prod' : 'dev')) {
      print('########## Request Log ##########');
      print('url: ${options.uri}');
      print('method: ${options.method}');
      print('data: ${options.data}');
      print('headers: ${options.headers}');
    }
  }

  @override
  Future onResponse(Response response) async {
    if (DotEnv().env['profile'] == (isProduction ? 'prod' : 'dev')) {
      print('########## Response Log ##########');
      print('data: ${response.data}');
    }
  }

  @override
  Future onError(DioError err) async {
    print('########## On Error ############');
    print('error: ${err.response}');
//     Verificar se deu erro 403 ou 401 fazer o refresh do token
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await _refreshToken();
      print('########## Access Token atualizado ############');
      final req = err.request;
      return CustomDio.authInstance.request(req.path, options: req);
    }

    print('########## Erro de Autenticação ############');
    if (err.response?.statusCode == 429) {
      final prefs = await SharedPrefsRepository.instance;
      Get.snackbar('Erro de autenticação',
          "Este usuário não tem permissão de acessar esta área do Sistema!");
      await prefs.logout();
    }
    return err;
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecurityStorageRepository();

    try {
//      final refreshToken = await security.refreshToken;
      final accessToken = prefs.token;
      var refreshResult = await CustomDio.authInstance.post('/usuarios/refresh',
//          data: {'token': accessToken, 'refreshToken': refreshToken},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          }));

      await prefs.registerAccessToken(refreshResult.data['data']['token']);
//      await security.registerRefreshToken(refreshResult.data['refresh_token']);
    } catch (e) {
      print(e);
      await prefs.logout();
    }
  }
}
