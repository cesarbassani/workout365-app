import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:workout365app/app/core/exceptions/workout365_exceptions.dart';
import 'package:workout365app/app/services/usuario_services.dart';
import 'package:workout365app/app/shared/components/loader.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _service;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: 'user@workout365.com');
  TextEditingController passwordController =
      TextEditingController(text: 'password');

  @observable
  bool obscureText = true;

  _LoginControllerBase(this._service);

  @action
  void mostrarSenhaUsuario() {
    obscureText = !obscureText;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(emailController.text, passwordController.text);
        Loader.hide();
        Modular.to.popAndPushNamed('/');
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Email e senha inválidos!');
      } catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Erro ao realizar login!');
      }
    }
  }
}
