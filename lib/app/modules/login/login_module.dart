import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_controller.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_module.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController(i.get())),
        Bind((i) => CadastroController(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => LoginPage()),
        Router('/cadastro', module: CadastroModule()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
