import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/loja/detalhes/detalheModulo.dart';
import 'package:workout365app/app/modules/treino/home/inicioTreino.dart';

import 'card_modulosRecomendados.dart';

class OutrosNiveis extends StatelessWidget {
  const OutrosNiveis({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: <Widget>[
        Cards_ProximosModulos(
          image: "lib/assets/images/Costas2.jpg",
          press: () {},
        ),
        Cards_ProximosModulos(
          image: "lib/assets/images/Costas2.jpg",
          press: () {},
        )
      ]),
    );
  }
}

class Cards_ProximosModulos extends StatelessWidget {
  const Cards_ProximosModulos({
    Key key,
    this.image,
    this.press,
  }) : super(key: key);
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 20 / 2, bottom: 20 / 2),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            )),
      ),
    );
  }
}

class CarregarRecomendados extends StatelessWidget {
  const CarregarRecomendados({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    _iniciarTreino() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InicioTreino()));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          CardsModulosRecomendados(
            size: size,
            image: 'lib/assets/images/Abdominal.jpg',
            titulo: 'Abdominal',
            modulo: '8 Exercícios',
            preco: 15,
            press: () {
              _iniciarTreino();
            },
          ),
          CardsModulosRecomendados(
            size: size,
            image: 'lib/assets/images/Perna.jpg',
            titulo: 'Pernas',
            modulo: '6 Exercícios',
            preco: 25,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheModulo(
                    titulo: 'Módulo 02',
                    descricao: '2 Meses',
                    preco: 25,
                  ),
                ),
              );
            },
          ),
          CardsModulosRecomendados(
            size: size,
            image: 'lib/assets/images/Alongamento.jpg',
            titulo: 'Alongamento',
            modulo: '10 Exercícios',
            preco: 5,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheModulo(
                    titulo: 'Alongamento',
                    descricao: '10 Exercícios',
                    preco: 5,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
