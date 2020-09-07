import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/modules/treino/execucao/execucaoTreino.dart';
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
  executarTreino(TreinoCompletoModel treinoCompleto) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExecucaoTreino(
                  treinoCompleto: treinoCompleto,
                )));
  }

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
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      height: 120.0,
                      width: size.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: treinoCompleto.exercicios_treino.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _card(treinoCompleto, index, size),
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 0, bottom: 5.0, right: 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50.0,
                                  child: RaisedButton(
                                    onPressed: () {
                                      executarTreino(treinoCompleto);
                                    },
                                    color: Color(0xFF04959A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      "Iniciar Treino",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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

Widget _card(TreinoCompletoModel treinoCompleto, int index, Size size) {
  return Container(
    padding: EdgeInsets.only(left: 5, top: 15, right: 5),
    height: 100.0,
    width: 300,
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Colors.black,
      elevation: 2.0,
      child: Container(
        margin: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        height: 115.0,
        width: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      treinoCompleto.exercicios_treino[index].exercicio.nome,
                      style: TextStyle(
                          fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 2.0,
                      width: 150,
                      color: Color(0xFF04959A),
                    ),
                    SizedBox(height: 5),
                    Text(
                      treinoCompleto.exercicios_treino[index].exercicio
                          .categoria_exercicio.descricao,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Color(0xFF04959A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
