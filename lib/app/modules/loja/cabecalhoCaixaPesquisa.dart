import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/shared/auth_store.dart';

class CabecalhoComCaixaPesquisa extends StatelessWidget {
  const CabecalhoComCaixaPesquisa({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
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
                  Modular.get<AuthStore>().usuarioLogado.nome,
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
              "Bem vindo à loja de treinos",
              style: TextStyle(
                  fontFamily: 'Quicksand', color: Colors.white, fontSize: 14.0),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xFF414550).withOpacity(0.23))
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          hintText: "Pesquisar",
                          hintStyle: TextStyle(
                              color: Color(0xFF414550).withOpacity(0.5)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(Icons.search, color: Colors.black)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
