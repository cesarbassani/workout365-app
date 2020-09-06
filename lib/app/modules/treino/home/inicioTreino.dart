import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/shared/stores/treino_free_store.dart';

import '../capaTreino.dart';
import 'barraInformacoes.dart';

class InicioTreino extends StatefulWidget {
  final TreinoFreeModel treinoFree;

  const InicioTreino({Key key, this.treinoFree}) : super(key: key);

  @override
  _InicioTreinoState createState() => _InicioTreinoState();
}

class _InicioTreinoState extends State<InicioTreino> {
  final TreinoFreeStore treinoFreeStore = TreinoFreeStore();

  @override
  void initState() {
    super.initState();
    treinoFreeStore.initPage(widget.treinoFree.id);
  }
  // final String modulo, treino;

  //_InicioTreinoState(this.modulo, this.treino);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _body(size, context, treinoFreeStore),
    );
  }
}

Widget _body(Size size, BuildContext context, TreinoFreeStore treinoFreeStore) {
  return SingleChildScrollView(
    child: Observer(builder: (_) {
      return FutureBuilder<List<TreinoCompletoModel>>(
        future: treinoFreeStore.treinoFutureSelecionado,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                heightFactor: ScreenUtil.defaultHeight.toDouble(),
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                var treino = snapshot.data;
                var treinoCompleto = TreinoCompletoModel();
                treino.forEach((treinoSelecionado) {
                  treinoCompleto = treinoSelecionado;
                });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CapaTreino(
                      size: size,
                      treinoCompleto: treinoCompleto,
                    ),
                    BarraInformacoes(treinoCompleto: treino),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        "Informações",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Equipamentos necessários: ${treinoCompleto.equipamentos.map((value) => value)}",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Color(0xFF04959A),
                                    style: BorderStyle.solid,
                                    width: 3.0))),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Exercícios',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Timesroman',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.0, left: 15.0),
                      height: 125.0,
                      width: double.infinity,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: treinoCompleto.exercicios_treino.length,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _card(treinoCompleto, index),
                                SizedBox(width: 10.0),
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: 15),
                  ],
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.redAccent),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      "Nenhum treino encontrado!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              }
              break;
            default:
              return Container();
          }
        },
      );
    }),
  );
}

Widget _card(TreinoCompletoModel treinoCompleto, int index) {
  return Container(
    padding: EdgeInsets.only(
      left: 5.0,
      top: 5,
      right: 5,
    ),
    height: 125.0,
    width: 250.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
                image: AssetImage("lib/assets/images/triceps.jpg"),
                fit: BoxFit.cover),
          ),
          height: 125.0,
          width: 100.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                treinoCompleto.exercicios_treino[index].exercicio.nome,
                style: TextStyle(
                  fontFamily: 'Quicksand',
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                treinoCompleto
                    .exercicios_treino[index].tempo_total_por_exercicio
                    .toString(),
                style: TextStyle(
                  fontFamily: 'Quicksand',
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 2.0,
                width: 75.0,
                color: Color(0xFF04959A),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 25.0,
                    width: 100.0,
                    child: SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        rating: 3.0,
                        size: 15.0,
                        color: Color(0XFF04959A),
                        borderColor: Color(0XFF04959A),
                        spacing: 0.0),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget _card2() {
  return Container(
    height: 125.0,
    width: 250.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
                image: AssetImage("lib/assets/images/apoio.jpg"),
                fit: BoxFit.cover),
          ),
          height: 125.0,
          width: 100.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Apoio',
              style: TextStyle(
                fontFamily: 'Quicksand',
              ),
            ),
            Text(
              '20 min',
              style: TextStyle(
                fontFamily: 'Quicksand',
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 2.0,
              width: 75.0,
              color: Color(0xFF04959A),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 25.0,
                  width: 100.0,
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: 5.0,
                      size: 15.0,
                      color: Color(0XFF04959A),
                      borderColor: Color(0XFF04959A),
                      spacing: 0.0),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
