import 'package:flutter/material.dart';

class BeneficiosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 25.0),
          Text(
            "Benefícios da Assinatura",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 25.0),
          Text(
            "Objetivo do projeto é mostrar que a atividade física bem orientada e pautada em métodos comprovadamente eficazes e de fácil entendimento para o publico leigo, proporciona um melhora física, mental, social e profissional. Corpo e mente trabalhando em sinergia.",
            style: TextStyle(color: Colors.black38),
          ),
          SizedBox(height: 25.0),
          Text(
            "Sobre o projeto",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15.0),
          Text(
            "Visando atender todos os públicos ( Iniciante, intermediário, avançado e atletas) desenvolvemos treinos com enfoque na evolução gradual e segura dos praticantes. Melhorando tanto a qualidade de vida como a performance de atletas.",
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
