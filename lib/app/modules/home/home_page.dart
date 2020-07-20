import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:workout365app/app/modules/loja/loja_page.dart';
import 'package:workout365app/app/modules/treino/execucao/execucaoTreino.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio_Page(),
      Loja_Page(),
      ExecucaoTreino(),
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
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
                    child: Text('Work',
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 60.0, 0.0, 0.0),
                    child: Text('Out',
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(84.0, 75.0, 0.0, 0.0),
                    child: Text('365',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF04959A))),
                  )
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
                //_meuTreino();
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
              icon: Icon(Icons.directions_run, color: Colors.black)),
          BottomNavigationBarItem(
              title: Text("Execucao"),
              icon: Icon(Icons.person, color: Colors.black)),
        ],
      ),
    );
  }
}
