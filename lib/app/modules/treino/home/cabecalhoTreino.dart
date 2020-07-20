import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/treino/home/inicioTreino.dart';

class CabecalhoTreino extends StatelessWidget {
  const CabecalhoTreino({
    Key key,
    @required this.size,
    this.moduloUsuario,
  }) : super(key: key);

  final Size size;
  final String moduloUsuario;

  @override
  Widget build(BuildContext context) {
    _iniciarTreino() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InicioTreino()));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: size.height * 0.1,
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
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text(
              moduloUsuario,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
