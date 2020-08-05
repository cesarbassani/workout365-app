import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:workout365app/app/services/usuario_services.dart';
import 'package:workout365app/app/shared/components/loader.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _service;

  _CadastroControllerBase(this._service);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  MaskedTextController telefoneController =
      MaskedTextController(mask: '(00)00000-0000');
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  @observable
  bool esconderSenha = true;

  @observable
  bool esconderConfirmaSenha = true;

  @observable
  String genero = "feminino";

  @action
  void mostrarSenha() => esconderSenha = !esconderSenha;

  @action
  void mostrarConfirmaSenha() => esconderConfirmaSenha = !esconderConfirmaSenha;

  @action
  Future<void> cadastrarUsuario() async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        await _service.cadastrarUsuario(
            nomeController.text,
            cpfController.text,
            emailController.text,
            telefoneController.text,
            genero.toLowerCase(),
            senhaController.text,
            confirmaSenhaController.text);
        Loader.hide();
        Modular.to.pop();
        Get.snackbar(
          'Sucesso',
          "Cadastro realizado com sucesso",
          duration: Duration(seconds: 5),
          shouldIconPulse: true,
          titleText: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.done,
                color: Colors.greenAccent,
                size: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
              ),
              Text(
                "Cadastrado",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          messageText: Text(
            "Cadastro realizado com sucesso",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      } on DioError catch (e) {
        if (e?.response?.statusCode == 422) {
          Loader.hide();

          List<String> msgsError = [];
          String msgEmail = e.response.data['errors']['email']?.first;
          String msgCpf = e.response.data['errors']['cpf']?.first;

          msgEmail != null ? msgsError.add("${msgEmail}\n\n") : msgEmail = '';
          msgCpf != null ? msgsError.add(msgCpf) : msgCpf = '';

          String msg = msgsError.join();
          Get.snackbar(
            'Erro',
            msg,
            duration: Duration(seconds: 5),
            shouldIconPulse: true,
            titleText: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.yellowAccent,
                  size: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                Text(
                  "Erro",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            messageText: Text(
              msg,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          );
        } else {
          Get.snackbar('Erro', "Erro ao cadastrar usuário!");
        }
      }
    }
  }
}
