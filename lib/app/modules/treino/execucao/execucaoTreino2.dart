import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/assinatura/pricePage/sobreTab.dart';
import 'package:workout365app/app/modules/treino/execucao/cabecalhoImagemTreino.dart';
import 'package:workout365app/app/modules/treino/execucao/seriesTabs.dart';
import 'package:workout365app/app/modules/treino/home/barraInformacoes.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ExecucaoTreino2 extends StatefulWidget {
  @override
  _ExecucaoTreino2State createState() => _ExecucaoTreino2State();
}

class _ExecucaoTreino2State extends State<ExecucaoTreino2> {
  // final String modulo, treino;

  //_InicioTreinoState(this.modulo, this.treino);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CabecalhoImagemTreino(size: size),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 15.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Supino inclinado com barra",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Fazer o exercício com 15 quilos de cada lado.",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5E5B54),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                    child: TabBar(
                      unselectedLabelColor: Colors.black,
                      indicator: BoxDecoration(
                        color: Color(0xFF04959A),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      tabs: [
                        Tab(text: "Execução"),
                        Tab(text: "Detalhes"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SeriesTabs(),
                        SeriesTabs(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
