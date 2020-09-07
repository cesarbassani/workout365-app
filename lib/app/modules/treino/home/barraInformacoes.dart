import 'package:flutter/material.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';

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

    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(treinoCompleto.nome,
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 5),
                Text(
                  treinoCompleto.grupos_muculares
                      .map((grupo) => grupo)
                      .toString(),
                  style: TextStyle(color: Colors.black38),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
