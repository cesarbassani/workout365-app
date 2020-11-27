import 'package:flutter/material.dart';

class SobreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 25.0),
          Text(
            "Sobre Nós",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15.0),
          Text(
            "Objetivo do projeto é mostrar que a atividade física bem orientada e pautada em métodos comprovadamente eficazes e de fácil entendimento para o publico leigo, proporciona um melhora física, mental, social e profissional. Corpo e mente trabalhando em sinergia.",
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
