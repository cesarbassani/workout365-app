import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/modules/treino/home/inicioTreino.dart';
import 'package:workout365app/app/shared/auth_store.dart';
import 'package:workout365app/app/shared/stores/treino_free_store.dart';

import 'cabecalho.dart';
import 'cartao_assinatura.dart';

class Inicio_Page extends StatefulWidget {
  @override
  _Inicio_PageState createState() => _Inicio_PageState();
}

class _Inicio_PageState extends State<Inicio_Page> {
  final TreinoFreeStore treinoFreeStore = TreinoFreeStore();

  @override
  void initState() {
    super.initState();
    treinoFreeStore.listarTreinosFree();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(height: 250.0, color: Colors.white70),
                Column(
                  children: <Widget>[
                    Cabecalho(
                      size: size,
                      mensagemAssinatura: "Preparado para treinar?",
                    ),
                    CartaoAssinatura(
                      imagemFundo: "lib/assets/images/halteres.jpg",
                      nome: Modular.get<AuthStore>().usuarioLogado.nome,
                      moduloAssinatura: "Nível Iniciante - Módulo 01",
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
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
                                  'Treinos Gratuítos',
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
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 15.0,
                        right: 15,
                        bottom: 15,
                      ),
                      height: 150.0,
                      width: double.infinity,
                      child: _bodyTreinos(),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyTreinos() {
    return Container(
      child: Observer(
        builder: (_) {
          return FutureBuilder<List<TreinoFreeModel>>(
            future: treinoFreeStore.treinoFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildItemTreino(data[index], index),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          );
                        },
                        // ignore: missing_return
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Nenhum treino gratuíto cadastrado!",
                      ),
                    );
                  }
                  break;
                default:
                  return Container();
              }
            },
          );
        },
      ),
    );
  }

  Widget _card(TreinoFreeModel treinoFree, int index) {
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      height: 100.0,
      width: 250.0,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.black,
        elevation: 2.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InicioTreino(
                          treinoFree: treinoFree,
                        )));
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: AssetImage("lib/assets/images/k365.png"),
                      fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        treinoFree.nome,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 2.0,
                      width: 75.0,
                      color: Color(0xFF04959A),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      treinoFree.tempo_treino + ' min',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildItemTreino(TreinoFreeModel treinoFree, int index) {
    return _card(treinoFree, index);
  }
}
