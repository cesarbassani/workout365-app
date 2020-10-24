import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/modules/home/assinante/cardProximoTreino.dart';
import 'package:workout365app/app/modules/home/inicio/cabecalho.dart';
import 'package:workout365app/app/modules/treino/home/inicioTreino.dart';
import 'package:workout365app/app/shared/auth_store.dart';
import 'package:workout365app/app/shared/stores/treino_free_store.dart';

import 'cabecalhoAssinante.dart';

class AssinanteHome extends StatefulWidget {
  @override
  _AssinanteHome_PageState createState() => _AssinanteHome_PageState();
}

class _AssinanteHome_PageState extends State<AssinanteHome> {
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
                Container(height: 250.0, color: Colors.white),
                Column(
                  children: <Widget>[
                    CabecalhoAssinante(
                      size: size,
                    ),
                    Positioned(
                      top: size.height * 0.38,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white,
                        height: size.height * 0.50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CardProximoTreino(
                                size: size,
                                image: 'lib/assets/images/Abdominal.jpg',
                                titulo: 'Peito e Perna Avançado',
                                modulo: '8 Exercícios',
                                press: () {},
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0, bottom: 15),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Últimos Treinos Executados',
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
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 32,
                                    ),
                                    _bodyTreinos(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
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

  Widget _treinosCard(TreinoFreeModel treinoFree, int index) {
    return Container(
      //width: 150.0,
      margin: const EdgeInsets.only(
        right: 10,
        bottom: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(
                  "lib/assets/images/Costas2.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      treinoFree.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      treinoFree.categoria,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.black12,
                          size: 15,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "50 min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                      '15 min',
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

  _buildItemTreino2(TreinoFreeModel treinoFree, int index) {
    return _treinosCard(treinoFree, index);
  }
}
