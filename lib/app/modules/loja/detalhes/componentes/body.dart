import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/loja/detalhes/componentes/precoeTitulo.dart';
import 'botoesInferiores.dart';
import 'iconeseImagem.dart';

class Body extends StatelessWidget{
  const Body({
    Key key, this.titulo, this.descricao, this.preco,
  }) : super(key: key);

  final String titulo, descricao;
  final int preco;

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          IconeseImagem(size: size),
          TituloePreco(titulo: titulo, descricao: descricao, preco: preco,),
          SizedBox(height: 20),
          BotoesInferiores(size: size),
        ],
      ),
    );
  }
}
