import 'package:flutter/material.dart';


class BotoesInferiores extends StatelessWidget {
  const BotoesInferiores({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        width: size.width / 2,
        height: 84,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
             topRight: Radius.circular(20),
            )
            ),
          color: Color(0xFF04959A),
          onPressed: (){},
          child: 
          Text(
            "Comprar Agora",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          ),
        ),
      ),
      Expanded(
        child: FlatButton(onPressed: (){}, child: Text("Detalhes"),),
      )
    ],
    );
  }
}
