import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
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
      body: Column(
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
                    padding: EdgeInsets.only(top: 15.0, left: 15.0),
                    height: 100.0,
                    child: _bodyServicos(),
//                    ListView(
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                      children: <Widget>[
//                        _card(),
//                        SizedBox(width: 10.0),
//                        _card2(),
//                        SizedBox(width: 10.0),
//                        _card(),
//                        SizedBox(width: 10.0),
//                        _card2(),
//                      ],
//                    ),
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
    );
  }

  Widget _bodyServicos() {
    return Expanded(
      flex: 8,
      child: Observer(
        builder: (_) {
          return FutureBuilder<List<TreinoFreeModel>>(
            future: treinoFreeStore.servicoFuture,
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
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) =>
                          _buildItemTreino(data[index], index),
                      // ignore: missing_return
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

  Widget _card() {
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
                  image: AssetImage("lib/assets/images/triceps.jpg"),
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
                'Aquecimento',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                ),
              ),
              Text(
                '15 min',
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
          )
        ],
      ),
    );
  }

  _buildItemTreino(TreinoFreeModel data, int index) {
    return Observer(builder: (_) {
      return _card();
    });
  }
}
