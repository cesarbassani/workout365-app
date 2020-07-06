import 'package:flutter/material.dart';


class TituloePreco extends StatelessWidget {
  const TituloePreco({
    Key key, this.titulo, this.descricao, this.preco,
  }) : super(key: key);

  final String titulo, descricao;
  final int preco;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: <Widget>[
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "$titulo\n",
              style: Theme.of(context).textTheme.headline4.copyWith(
               fontWeight: FontWeight.bold)
            ),
            TextSpan(
              text: descricao,
              style: TextStyle(
              color: Color(0xFF04959A), fontWeight: FontWeight.w300
              ),
            ),
          ]),
        ),
        Spacer(),
        Text(
          "R\$ $preco",
          style: Theme.of(context).textTheme.headline5.copyWith(color: Color(0xFF04959A)),
        )
      ],),
    );
  }
}
