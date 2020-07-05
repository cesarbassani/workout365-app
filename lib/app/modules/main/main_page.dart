import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/shared/auth_store.dart';

class MainPage extends StatelessWidget {

  MainPage() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authStore = Modular.get<AuthStore>();

      final isLogged = await authStore.isLogged();

      if(isLogged) {
        Modular.to.pushNamedAndRemoveUntil('/home', (_) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('lib/assets/images/logo.png'),
        ),
      ),
    );
  }
}
