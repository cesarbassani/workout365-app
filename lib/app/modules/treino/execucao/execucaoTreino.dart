import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:workout365app/app/models/exercicios_treino_model.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:clay_containers/clay_containers.dart';

import 'barItem.dart';

class ExecucaoTreino extends StatefulWidget {
  final TreinoCompletoModel treinoCompleto;

  const ExecucaoTreino({Key key, this.treinoCompleto}) : super(key: key);

  @override
  _ExecucaoTreinoState createState() => _ExecucaoTreinoState();
}

class _ExecucaoTreinoState extends State<ExecucaoTreino> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  int step = 0;

  @override
  void initState() {
    var exerciciosTreino = ExerciciosTreinoModel();
    widget.treinoCompleto.exercicios_treino.forEach((treino) {
      exerciciosTreino = treino;
    });
    _inicializaVideo();
    super.initState();
    print(widget
        .treinoCompleto.exercicios_treino[0].exercicio.categoria_exercicio);
  }

  int selectedIndex = 0;
  void onItemTapped(int tappedItemIndex) {
    setState(() {
      selectedIndex = tappedItemIndex;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.treinoCompleto.nome),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xFF414550),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.black,
          ),
          Container(
            height: screenHeight - (screenHeight / 2) + 50,
            width: screenWidth,
            child: _carregaVideo(),
          ),
          Positioned(
            top: screenHeight / 2 + 30,
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              height: screenHeight / 2 + 25.0,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    widget
                        .treinoCompleto.exercicios_treino[step].exercicio.nome,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    height: 3.0,
                    width: 100.0,
                    color: Color(0xFF04959A),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClayContainer(
                height: 60,
                borderRadius: 10,
                color: Colors.white,
                spread: 0,
                depth: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BarItem(
                        icon: Icons.home,
                        title: 'Treino',
                        isSelected: selectedIndex == 0,
                        onTap: () {
                          onItemTapped(0);
                        },
                      ),
                      BarItem(
                        icon: Icons.keyboard_arrow_left,
                        isSelected: selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            if (step >= 1) {
                              step--;
                              _inicializaVideo();
                            }
                          });
                        },
                      ),
                      BarItem(
                        icon: Icons.info_outline,
                        isSelected: selectedIndex == 2,
                        onTap: () {
                          _mostrarModal(context, widget.treinoCompleto);
                        },
                      ),
                      BarItem(
                        icon: Icons.keyboard_arrow_right,
                        isSelected: selectedIndex == 3,
                        onTap: () {
                          setState(() {
                            if (step <
                                (widget.treinoCompleto.exercicios_treino
                                        .length -
                                    1)) {
                              step++;
                              _inicializaVideo();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight / 2 - 50.0,
            right: 25.0,
            child: Hero(
              tag: "text",
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/logoNovaPreto.png'),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carregaVideo() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _inicializaVideo() {
    _controller = VideoPlayerController.network(
        "https://homapi.workout365.com.br/public/api/exercicios/videos/streaming/${widget.treinoCompleto.exercicios_treino[step].exercicio_id}");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
//    _controller.seekTo(Duration(seconds: 1));
    _controller.play();
  }

  void _mostrarModal(context, TreinoCompletoModel treinoCompleto) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
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
                                height: 25.0,
                              ),
                              Text(
                                treinoCompleto
                                    .exercicios_treino[step].exercicio.nome,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                height: 3.0,
                                width: 100.0,
                                color: Color(0xFF04959A),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                widget.treinoCompleto.exercicios_treino[step]
                                    .exercicio.descricao,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0XFF04959A),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                treinoCompleto.exercicios_treino[step].exercicio
                                    .categoria_exercicio.descricao,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black38,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                "Grupo Muscular: ${treinoCompleto.grupos_muculares.map((grupo) => grupo)}",
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
                                margin: EdgeInsets.only(top: 70),
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
}
