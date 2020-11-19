import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/shared/components/my_text.dart';

class BarraInformacoes extends StatefulWidget {
  final List<TreinoCompletoModel> treinoCompleto;

  const BarraInformacoes({
    Key key,
    this.treinoCompleto,
  }) : super(key: key);

  @override
  _BarraInformacoesState createState() => _BarraInformacoesState();
}

class _BarraInformacoesState extends State<BarraInformacoes>
    with TickerProviderStateMixin {
  bool expand1 = false;
  Animation<double> animation1, animation1View;
  AnimationController controller1;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1);
    animation1View = CurvedAnimation(parent: controller1, curve: Curves.linear);
    controller1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var treinoCompleto = TreinoCompletoModel();
    widget.treinoCompleto.forEach((treino) {
      treinoCompleto = treino;
    });

    return Padding(
      padding: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(treinoCompleto.nome,
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], height: 0, thickness: 0.5),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.accessibility, size: 25.0, color: Colors.grey),
                      Container(width: 10),
                      Text("Grupos Musculares",
                          style: MyText.subhead(context).copyWith(
                              color: Colors.grey, fontWeight: FontWeight.w400)),
                      Spacer(),
                      Transform.rotate(
                        angle: animation1.value * math.pi / 180,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            togglePanel1();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizeTransition(
                  sizeFactor: animation1View,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          treinoCompleto.grupos_muculares
                              .toSet()
                              .toList()
                              .toString()
                              .replaceAll(new RegExp(r'[\]\[]'), ''),
                          // .map((grupo) => grupo)
                          // .toString(),
                          style: TextStyle(color: Colors.black38),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(width: 10),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200], height: 0, thickness: 0.5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void togglePanel1() {
    if (!expand1) {
      controller1.forward();
    } else {
      controller1.reverse();
    }
    expand1 = !expand1;
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }
}
