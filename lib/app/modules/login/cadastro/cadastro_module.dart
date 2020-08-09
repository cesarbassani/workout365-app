import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_controller.dart';
import 'package:workout365app/app/modules/login/cadastro/cadastro_page.dart';

class CadastroModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CadastroController(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => CadastroPage()),
      ];

  static Inject get to => Inject<CadastroModule>.of();
}
