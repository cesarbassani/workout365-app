import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workout365app/app/modules/loja/proximosNiveis.dart';
import 'package:workout365app/app/modules/loja/titulo_botaoMais.dart';

import 'cabecalhoCaixaPesquisa.dart';
import 'card_modulosRecomendados.dart';

class Loja_Page extends StatefulWidget {
  
   @override
  _Loja_PageState createState() => _Loja_PageState();

}

class _Loja_PageState extends State<Loja_Page> {


  @override
  Widget build(BuildContext context){
    //Define o tamanho total de altura e largura da pagina
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          CabecalhoComCaixaPesquisa(size: size),
          TituloComBotaoMais(titulo: "Módulos Nível Iniciante", press: (){},),
          CarregarRecomendados(size: size),
          TituloComBotaoMais(titulo: "Outros Níveis", press: (){},),
          OutrosNiveis(),
          SizedBox(height: 20),
        ],
      ),
      ),
    );
  }

}
