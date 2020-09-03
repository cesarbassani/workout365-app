import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../capaTreino.dart';
import 'barraInformacoes.dart';

class InicioTreino extends StatefulWidget {
  @override
  _InicioTreinoState createState() => _InicioTreinoState();
}

class _InicioTreinoState extends State<InicioTreino> {
  // final String modulo, treino;

  //_InicioTreinoState(this.modulo, this.treino);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CapaTreino(size: size),
        SizedBox(height: 10),
        BarraInformacoes(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            "Informações",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Equipamentos necessários: Halteres e Colchonete",
            style: TextStyle(color: Colors.black38),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: Color(0xFF04959A),
                        style: BorderStyle.solid,
                        width: 3.0))),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Exercícios',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Timesroman',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15.0, left: 15.0),
          height: 125.0,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _card(),
              SizedBox(width: 10.0),
              _card2(),
              SizedBox(width: 10.0),
              _card(),
              SizedBox(width: 10.0),
              _card2(),
            ],
          ),
        ),
      ],
    ));
  }
}

Widget _card() {
  return Container(
    height: 125.0,
    width: 250.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
                image: AssetImage("lib/assets/images/triceps.jpg"),
                fit: BoxFit.cover),
          ),
          height: 125.0,
          width: 100.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Aquecimento',
              style: TextStyle(
                fontFamily: 'Quicksand',
              ),
            ),
            Text(
              '15 min',
              style: TextStyle(
                fontFamily: 'Quicksand',
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 2.0,
              width: 75.0,
              color: Color(0xFF04959A),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 25.0,
                  width: 100.0,
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: 3.0,
                      size: 15.0,
                      color: Color(0XFF04959A),
                      borderColor: Color(0XFF04959A),
                      spacing: 0.0),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget _card2() {
  return Container(
    height: 125.0,
    width: 250.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
                image: AssetImage("lib/assets/images/apoio.jpg"),
                fit: BoxFit.cover),
          ),
          height: 125.0,
          width: 100.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Apoio',
              style: TextStyle(
                fontFamily: 'Quicksand',
              ),
            ),
            Text(
              '20 min',
              style: TextStyle(
                fontFamily: 'Quicksand',
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 2.0,
              width: 75.0,
              color: Color(0xFF04959A),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 25.0,
                  width: 100.0,
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: 5.0,
                      size: 15.0,
                      color: Color(0XFF04959A),
                      borderColor: Color(0XFF04959A),
                      spacing: 0.0),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
