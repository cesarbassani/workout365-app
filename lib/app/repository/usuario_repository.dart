import 'package:dio/dio.dart';
import 'package:workout365app/app/core/dio/custom_dio.dart';
import 'package:workout365app/app/models/access_token_model.dart';
import 'package:workout365app/app/models/confirm_login_model.dart';
import 'package:workout365app/app/models/usuario_model.dart';
import 'package:workout365app/app/repository/shared_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login({String email, String password}) {
    // Enviar dados pelo formData
    FormData formData =
        FormData.fromMap({"email": email, "password": password});
    return CustomDio.instance
        .post('/usuarios/login',
            data: {"email": email, "password": password},
            options: Options(headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            }))
        .then((res) => AccessTokenModel.fromJson(res.data['data']));
  }

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;

    return CustomDio.authInstance
        .post('/usuarios/refresh',
            data: {},
            options: Options(headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            }))
        .then((res) => ConfirmLoginModel.fromJson(res.data['data']));
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() {
    return CustomDio.authInstance
        .get('/usuarios/logado',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            }))
        .then((res) => UsuarioModel.fromJson(res.data['data']));
  }

  Future<void> cadastrarUsuario(
      String nome,
      String cpf,
      String email,
      String telefone,
      String sexo,
      String password,
      String passwordConfirmation) async {
    await CustomDio.authInstance.post('/usuarios',
        data: {
          'nome': nome,
          'cpf': cpf,
          'email': email,
          'telefone': telefone,
          'sexo': sexo,
          'gestor': true,
          'password': password,
          'password_confirmation': passwordConfirmation
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        }));
  }
}
