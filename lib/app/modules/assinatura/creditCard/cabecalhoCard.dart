import 'package:flutter/material.dart';

class CabecalhoCard extends StatelessWidget {
  const CabecalhoCard({
    Key key,
    @required this.size,
    this.mensagemAssinatura,
  }) : super(key: key);

  final Size size;
  final String mensagemAssinatura;

  @override
  Widget build(BuildContext context) {
    // _iniciarTreino() {
    //  Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => InicioTreino()));
    // }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF414550),
                      Color(0xFF18191E),
                    ]),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(36))),
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'lib/assets/images/logoGrandeBranca.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
