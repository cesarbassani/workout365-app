import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workout365app/app/modules/loja/detalhes/componentes/body.dart';

class DetalheModulo extends StatelessWidget{
  const DetalheModulo({
    Key key, this.titulo, this.descricao, this.preco,
  }) : super(key: key);

  final String titulo, descricao;
  final int preco;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Body(titulo: titulo, descricao: descricao, preco: preco,),
    );
  }
}