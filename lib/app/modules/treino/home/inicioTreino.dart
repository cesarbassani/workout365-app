import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/models/usuario_treino_model.dart';
import 'package:workout365app/app/modules/treino/execucao/execucaoTreino.dart';
import 'package:workout365app/app/services/treino_free_services.dart';
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
  final TreinoFreeServices treinoFreeServices = TreinoFreeServices();

  int step = 0;

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
      body: _body(size, context, treinoFreeStore, treinoFreeServices),
    );
  }
}

Widget _body(Size size, BuildContext context, TreinoFreeStore treinoFreeStore,
    TreinoFreeServices treinoFreeServices) {
  executarTreino(
      TreinoCompletoModel treinoCompleto, UsuarioTreinoModel usuarioTreino) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExecucaoTreino(
          treinoCompleto: treinoCompleto,
          treinoIniciado: true,
          usuarioTreino: usuarioTreino,
        ),
      ),
    );
  }

  return SingleChildScrollView(
    padding: EdgeInsets.only(bottom: 20),
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
                        "Equipamentos necessários: ${treinoCompleto.equipamentos.toSet().toList().toString().replaceAll(new RegExp(r'[\]\[]'), '')}",
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
                                _card(treinoCompleto, index, size, context),
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
                                    onPressed: () async {
                                      var usuarioTreino = UsuarioTreinoModel();
                                      if (treinoCompleto
                                              .quantidade_exercicios_treino >
                                          0) {
                                        String dataInicioTreino =
                                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                                .format(DateTime.now());
                                        usuarioTreino = await treinoFreeServices
                                            .enviarInicioTreino(treinoCompleto,
                                                dataInicioTreino);
                                        executarTreino(
                                            treinoCompleto, usuarioTreino);
                                      }
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

Widget _card(TreinoCompletoModel treinoCompleto, int index, Size size,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      _mostrarModal(context, treinoCompleto, index);
    },
    child: Container(
      padding: EdgeInsets.only(left: 5, top: 15, right: 5),
      height: 115.0,
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
        ),
      ),
    ),
  );
}

void _mostrarModal(context, TreinoCompletoModel treinoCompleto, int index) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white),
                child: Container(
                  padding: EdgeInsets.only(top: 12.0, right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              treinoCompleto
                                  .exercicios_treino[index].exercicio.nome,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              height: 3.0,
                              width: 100.0,
                              color: Color(0xFF04959A),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              treinoCompleto?.exercicios_treino[index].exercicio
                                          ?.descricao !=
                                      null
                                  ? treinoCompleto?.exercicios_treino[index]
                                      .exercicio?.descricao
                                  : treinoCompleto?.exercicios_treino[index]
                                      .exercicio?.nome,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF04959A),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              treinoCompleto.exercicios_treino[index].exercicio
                                  .categoria_exercicio.descricao,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Grupo Muscular: ${treinoCompleto.exercicios_treino[index].exercicio.grupos_musculares.map((grupo) => grupo)}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 399,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'lib/assets/images/logoGrande.png',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      });
}
