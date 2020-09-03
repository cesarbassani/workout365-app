import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/treino/execucao/execucaoTreino.dart';
import 'package:workout365app/app/modules/treino/execucao/execucaoTreino2.dart';

class BarraInformacoes extends StatelessWidget {
  const BarraInformacoes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _executarTreino() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ExecucaoTreino()));
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Treino 04", style: Theme.of(context).textTheme.headline3),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      "Costas, Pernas e Bíceps",
                      style: TextStyle(color: Colors.black38),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 64,
            width: 64,
            child: FlatButton(
              onPressed: () {
                _executarTreino();
              },
              color: Color(0xFF04959A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.play_arrow,
                size: 28,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
