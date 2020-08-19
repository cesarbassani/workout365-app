import 'package:flutter/material.dart';
import 'cabecalhoSobre.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(height: 250.0, color: Colors.white70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CabecalhoSobre(
                      size: size,
                      mensagemAssinatura: "Melhorando sua vida",
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "Objetivo",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Objetivo do projeto é mostrar que a atividade física bem orientada e pautada em métodos comprovadamente eficazes e de fácil entendimento para o publico leigo, proporciona um melhora física, mental, social e profissional. Corpo e mente trabalhando em sinergia.",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "Sobre o projeto",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Visando atender todos os públicos ( Iniciante, intermediário, avançado e atletas) desenvolvemos treinos com enfoque na evolução gradual e segura dos praticantes. Melhorando tanto a qualidade de vida como a performance de atletas.",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "Módulos de Treinos",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildListItem(
                              'Iniciante',
                              'lib/assets/images/Musculacao.png',
                              Color(0xFF04959A),
                              Colors.white),
                          _buildListItem(
                              'Intermediário',
                              'lib/assets/images/Funcional.png',
                              Color(0xFF04959A),
                              Colors.white),
                          _buildListItem(
                              'Avançado',
                              'lib/assets/images/Cardio.png',
                              Color(0xFF04959A),
                              Colors.white),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

_buildListItem(
    String foodName, String imgPath, Color bgColor, Color textColor) {
  return Padding(
    padding: EdgeInsets.only(left: 15.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: bgColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: foodName,
              child: Container(
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    imgPath,
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              foodName,
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
