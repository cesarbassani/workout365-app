import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/modules/assinatura/sobre/sobre.dart';
import 'package:workout365app/app/modules/loja/loja_page.dart';
import 'package:workout365app/app/modules/perfil/profile/profile.dart';
import 'package:workout365app/app/modules/treino/execucao/execucaoTreino.dart';
import 'package:workout365app/app/modules/treino/feedback/feedbackPage.dart';
import 'package:workout365app/app/repository/shared_prefs_repository.dart';

import 'home_controller.dart';
import 'inicio/inicio_page.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  int _indiceAtual = 0;
  String _resultado = "";

  _procederParaPagamento() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FeedbackPage()));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio_Page(),
      Loja_Page(),
      Sobre(),
      Profile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout 365"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xFF414550),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'lib/assets/images/logoGrande.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text("Perfil"),
              subtitle: Text("Minhas Informações"),
              isThreeLine: true,
              onTap: () {
                // _iniciarTreino();
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run, color: Colors.black),
              title: Text("Treino"),
              subtitle: Text("Meu Treino"),
              isThreeLine: true,
              onTap: () {
                _procederParaPagamento();
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black),
              title: Text("Sair"),
              subtitle: Text("Sair do App"),
              isThreeLine: true,
              onTap: () async {
                await (await SharedPrefsRepository.instance).logout();
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xFF04959A),
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
              title: Text("Inicio"),
              icon: Icon(Icons.home, color: Colors.black)),
          BottomNavigationBarItem(
              title: Text("Treinos"),
              icon: Icon(Icons.store, color: Colors.black)),
          BottomNavigationBarItem(
              title: Text("Sobre"),
              icon: Icon(Icons.credit_card, color: Colors.black)),
          BottomNavigationBarItem(
              title: Text("Perfil"),
              icon: Icon(Icons.person, color: Colors.black)),
        ],
      ),
    );
  }
}
