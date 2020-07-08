import 'package:flutter/material.dart';

class CartaoAssinatura extends StatelessWidget {
  const CartaoAssinatura({
    Key key,
    this.nome,
    this.moduloAssinatura,
    this.imagemFundo,
  }) : super(key: key);

  final String nome, moduloAssinatura, imagemFundo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Container(
            height: 199,
            width: 344,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: AssetImage(imagemFundo), fit: BoxFit.cover),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 12.0, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          nome,
                          style: TextStyle(
                              fontFamily: 'Timesroman',
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white),
                        ),
                        Text(
                          moduloAssinatura,
                          style: TextStyle(
                              fontFamily: 'Timesroman',
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white70),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 3.0,
                          width: 50.0,
                          color: Color(0xFF04959A),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 399,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'lib/assets/images/logoNova.png',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
