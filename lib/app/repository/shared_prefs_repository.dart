import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout365app/app/models/usuario_model.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/ACCESS_TOKEN/';
  static const _DADOS_USUARIO = '/DADOS_USUARIO/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  Future<void> registerDadosusuario(UsuarioModel usuario) async {
    await prefs.setString(_DADOS_USUARIO, jsonEncode(usuario));
  }

  UsuarioModel get dadosUsuario {
    if (prefs.containsKey(_DADOS_USUARIO)) {
      Map<String, dynamic> usuarioMapa =
          jsonDecode(prefs.getString(_DADOS_USUARIO));
      return UsuarioModel.fromJson(usuarioMapa);
    }
    return null;
  }

  Future<void> logout() async {
    prefs.clear();
    await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
  }
}
