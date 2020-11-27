import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/assinatura/creditCard/cardInformation.dart';
import 'package:workout365app/app/modules/assinatura/pricePage/priceInformation.dart';

class CabecalhoSobre extends StatelessWidget {
  const CabecalhoSobre({
    Key key,
    @required this.size,
    this.mensagemAssinatura,
  }) : super(key: key);

  final Size size;
  final String mensagemAssinatura;

  @override
  Widget build(BuildContext context) {
    _iniciarTreino() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CardInformation()));
    }

    _pricePage() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PriceInformation()));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 56),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF414550),
                      Color(0xFF18191E),
                    ]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                )),
            child: Row(
              children: <Widget>[
                Text(
                  "Workout 365",
                  style: TextStyle(
                      fontFamily: 'Timesroman',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30.0),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text(
              mensagemAssinatura,
              style: TextStyle(
                  fontFamily: 'Quicksand', color: Colors.white, fontSize: 14.0),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      width: 300,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Color(0xFF04959A),
                        color: Color(0xFF04959A),
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            // _iniciarTreino();
                            _pricePage();
                          },
                          child: Center(
                            child: Text(
                              'Seja Pro',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
