import 'package:dio/dio.dart';
import 'package:workout365app/app/core/exceptions/workout365_exceptions.dart';
import 'package:workout365app/app/repository/shared_prefs_repository.dart';
import 'package:workout365app/app/repository/usuario_repository.dart';

class UsuarioService {
  final UsuarioRepository _repository;
  UsuarioService(this._repository);

  Future<void> login(String email, String password) async {
    try {
      final accesTokenModel =
          await _repository.login(email: email, password: password);
      final prefs = await SharedPrefsRepository.instance;
      prefs.registerAccessToken(accesTokenModel.accessToken);

      final confirmModel = await _repository.confirmLogin();

      prefs.registerAccessToken(confirmModel.accessToken);

//      SecurityStorageRepository()
//          .registerRefreshToken(confirmModel.refreshToken);

      final dadosUsuario = await _repository.recuperaDadosUsuarioLogado();

      await prefs.registerDadosusuario(dadosUsuario);
    } on DioError catch (e) {
      if (e?.response?.statusCode == 403) {
        throw AcessoNegadoException(e.response.data['message'], exception: e);
      } else {
        rethrow;
      }
    } catch (e) {
      print('Erro ao fazer login');
      rethrow;
    }
  }

  Future<void> cadastrarUsuario(
      String nome,
      String cpf,
      String email,
      String sexo,
      String telefone,
      String password,
      String passwordConfirmation) async {
    await _repository.cadastrarUsuario(
        nome, cpf, email, sexo, telefone, password, passwordConfirmation);
  }
}
