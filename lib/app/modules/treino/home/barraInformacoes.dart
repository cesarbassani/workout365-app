import 'package:flutter/material.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/modules/treino/execucao/execucaoTreino.dart';

class BarraInformacoes extends StatefulWidget {
  final List<TreinoCompletoModel> treinoCompleto;

  const BarraInformacoes({
    Key key,
    this.treinoCompleto,
  }) : super(key: key);

  @override
  _BarraInformacoesState createState() => _BarraInformacoesState();
}

class _BarraInformacoesState extends State<BarraInformacoes> {
  @override
  Widget build(BuildContext context) {
    var treinoCompleto = TreinoCompletoModel();
    widget.treinoCompleto.forEach((treino) {
      treinoCompleto = treino;
    });
    _executarTreino(TreinoCompletoModel treinoCompleto) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExecucaoTreino(
                    treinoCompleto: treinoCompleto,
                  )));
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(treinoCompleto.nome,
                    style: Theme.of(context).textTheme.headline3),
                SizedBox(height: 5),
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
                _executarTreino(treinoCompleto);
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
