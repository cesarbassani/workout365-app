import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/app_widget.dart';
import 'package:workout365app/app/modules/home/home_module.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_controller.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_module.dart';
import 'package:workout365app/app/modules/login/login_controller.dart';
import 'package:workout365app/app/modules/login/login_module.dart';
import 'package:workout365app/app/modules/main/main_page.dart';
import 'package:workout365app/app/modules/treino/feedback/feedbackPage.dart';
import 'package:workout365app/app/repository/usuario_repository.dart';
import 'package:workout365app/app/services/usuario_services.dart';
import 'package:workout365app/app/shared/auth_store.dart';

import 'app_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => LoginController(i.get())),
        Bind((i) => CadastroController(i.get())),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
        Bind((i) => AuthStore()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (context, args) => MainPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/cadastro', module: CadastroModule()),
        ModularRouter('/feedbackPage', child: (_, __) => FeedbackPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
