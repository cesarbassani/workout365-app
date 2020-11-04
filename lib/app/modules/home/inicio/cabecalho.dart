import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/modules/assinatura/pricePage/priceInformation.dart';
import 'package:workout365app/app/shared/auth_store.dart';

class Cabecalho extends StatelessWidget {
  const Cabecalho({
    Key key,
    @required this.size,
    this.mensagemAssinatura,
  }) : super(key: key);

  final Size size;
  final String mensagemAssinatura;

  @override
  Widget build(BuildContext context) {
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
                  Modular.get<AuthStore>().usuarioLogado.nome.split(' ')[0],
                  style: TextStyle(
                      fontFamily: 'Timesroman',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30.0),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 200,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'lib/assets/images/logoGrandeBranca.png',
                      ),
                    ),
                  ),
                )
                //Image.asset('lib/assets/images/logo_branco.png')
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
                  GestureDetector(
                    onTap: () {
                      _pricePage();
                    },
                    child: Container(
                      height: 40.0,
                      width: 300,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Color(0xFF04959A),
                        color: Color(0xFF04959A),
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'Seja PRO',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
