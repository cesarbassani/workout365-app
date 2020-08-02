import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/loja/detalhes/detalheModulo.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          CardsModulosRecomendados(
            size: size,
            image: 'lib/assets/images/apoio.jpg',
            titulo: 'Módulo 01',
            modulo: '2 Meses',
            preco: 0,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheModulo(
                    titulo: 'Módulo 01',
                    descricao: '2 Meses',
                    preco: 0,
                  ),
                ),
              );
            },
          ),
          CardsModulosRecomendados(
            size: size,
            image: 'lib/assets/images/apoio.jpg',
            titulo: 'Módulo 02',
            modulo: '2 Meses',
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
            image: 'lib/assets/images/apoio.jpg',
            titulo: 'Módulo 03',
            modulo: '2 Meses',
            preco: 25,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheModulo(
                    titulo: 'Módulo 03',
                    descricao: '2 Meses',
                    preco: 25,
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
