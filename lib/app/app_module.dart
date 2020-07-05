import 'package:workout365app/app/modules/home/home_module.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_controller.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_module.dart';
import 'package:workout365app/app/modules/login/login_controller.dart';
import 'package:workout365app/app/modules/login/login_module.dart';
import 'package:workout365app/app/modules/main/main_page.dart';
import 'package:workout365app/app/shared/auth_store.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:workout365app/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => LoginController()),
        Bind((i) => CadastroController()),
        Bind((i) => AuthStore()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (context, args) => MainPage()),
        Router('/home', module: HomeModule()),
        Router('/login', module: LoginModule()),
        Router('/cadastro', module: CadastroModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
