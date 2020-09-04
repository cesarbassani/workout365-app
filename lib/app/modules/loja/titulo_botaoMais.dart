import 'package:flutter/material.dart';

class TituloComBotaoMais extends StatelessWidget {
  const TituloComBotaoMais({
    Key key,
    this.titulo,
    this.press,
  }) : super(key: key);

  final String titulo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 20 / 4),
              child: Row(
                children: <Widget>[
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: press,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color(0xFF04959A),
                    child: Text(
                      "Mais",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: 20 / 4),
              height: 7,
            ),
          )
        ],
      ),
    );
  }
}
