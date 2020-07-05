import 'package:workout365app/app/modules/login/cadastro/cadastro_controller.dart';

import 'login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_page.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_module.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
        Bind((i) => CadastroController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => LoginPage()),
        Router('/cadastro', module: CadastroModule()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
