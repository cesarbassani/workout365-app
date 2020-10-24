import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:video_player/video_player.dart';
import 'package:workout365app/app/models/exercicios_treino_model.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/usuario_treino_model.dart';
import 'package:workout365app/app/modules/treino/feedback/feedbackPage.dart';
import 'package:workout365app/app/modules/video/blocs/video_player/video_player_bloc.dart';
import 'package:workout365app/app/modules/video/blocs/video_player/video_player_event.dart';
import 'package:workout365app/app/modules/video/blocs/video_player/video_player_state.dart';
import 'package:workout365app/app/modules/video/models/video.dart';
import 'package:workout365app/app/modules/video/services/video_controller_service.dart';
import 'package:workout365app/app/modules/video/widgets/video_player_widget.dart';
import 'package:workout365app/app/services/treino_free_services.dart';

class ExecucaoTreino extends StatefulWidget {
  final TreinoCompletoModel treinoCompleto;
  final bool treinoIniciado;
  final UsuarioTreinoModel usuarioTreino;

  const ExecucaoTreino(
      {Key key, this.treinoCompleto, this.treinoIniciado, this.usuarioTreino})
      : super(key: key);

  @override
  _ExecucaoTreinoState createState() => _ExecucaoTreinoState();
}

class _ExecucaoTreinoState extends State<ExecucaoTreino> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  final TreinoFreeServices treinoFreeServices = TreinoFreeServices();

  int step = 0;

  bool _isStart = true;

  String _stopwatchText = '00:00:00';
  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(seconds: 1);

  void _startTimeout() {
    new Timer(_timeout, _handleTimeout);
  }

  void _handleTimeout() {
    if (_stopWatch.isRunning) {
      _startTimeout();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_stopWatch.isRunning) {
        _isStart = true;
        _stopWatch.stop();
      } else {
        _isStart = false;
        _stopWatch.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed() {
    if (_stopWatch.isRunning) {
      _startStopButtonPressed();
    }
    setState(() {
      _stopWatch.reset();
      _setStopwatchText();
    });
  }

  void _setStopwatchText() {
    _stopwatchText = _stopWatch.elapsed.inHours.toString().padLeft(2, '0') +
        ':' +
        (_stopWatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
        ':' +
        (_stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
  }

  @override
  void initState() {
    if (widget.treinoIniciado) {
      _startStopButtonPressed();
    }

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

  var validaUltimoExercicio = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Anterior',
      style: optionStyle,
    ),
    Text(
      'Index 1: Informacoes',
      style: optionStyle,
    ),
    Text(
      'Index 2: Proximo',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        if (step >= 1) {
          step--;
          _inicializaVideo();
          validaUltimoExercicio = false;
        }
      });
    }
    if (index == 2) {
      setState(() {
        if (step == widget.treinoCompleto.exercicios_treino.length - 1 &&
            validaUltimoExercicio) {
          _finalizarTreino(context);
        }
        if (step < (widget.treinoCompleto.exercicios_treino.length - 1)) {
          step++;
          _inicializaVideo();
        } else {
          validaUltimoExercicio = true;
        }
      });
    }
    if (index == 1) {
      _mostrarModal(context, widget.treinoCompleto);
    }
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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: screenHeight * 0.87,
              width: screenWidth,
              color: Colors.white,
            ),
            SwipeDetector(
              onSwipeLeft: () {
                setState(() {
                  if (step <
                      (widget.treinoCompleto.exercicios_treino.length - 1)) {
                    step++;
                    _inicializaVideo();
                  }
                });
              },
              onSwipeRight: () {
                setState(() {
                  if (step >= 1) {
                    step--;
                    _inicializaVideo();
                  }
                });
              },
              child: Container(
                height: (screenHeight / 2) - 30,
                width: screenWidth,
                child: _carregaVideo(),
              ),
            ),
            Positioned(
              top: (screenHeight * 0.33) - 8,
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                height: screenHeight / 2 + 60,
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      widget.treinoCompleto.exercicios_treino[step].exercicio
                          .nome,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 3.0,
                      width: 100.0,
                      color: Color(0xFF04959A),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Método: " +
                          widget.treinoCompleto.exercicios_treino[step]
                              .metodo_treino +
                          "\nSéries: " +
                          widget.treinoCompleto.exercicios_treino[step]
                              .numero_series
                              .toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF04959A),
                      ),
                    ),
                    Container(
                      height: 110.0,
                      width: screenWidth,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.treinoCompleto
                              .exercicios_treino[step].numero_series,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _series(widget.treinoCompleto, index),
                              ],
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 150.0,
                      width: screenWidth * 0.92,
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Colors.black,
                        elevation: 2.0,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 20),
                          height: 150.0,
                          width: 100.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Evolução do Treino - " +
                                            widget.treinoCompleto.nome,
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10.0),
                                      Container(
                                        height: 2.0,
                                        width: screenWidth * 0.92 - 30,
                                        color: Color(0xFF04959A),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: EdgeInsets.only(left: 100),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.timer,
                                                    size: 20.0,
                                                    color: Colors.black),
                                                SizedBox(width: 10),
                                                Text(
                                                  _stopwatchText,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      _IngredientProgress(
                                        ingredient: "Progresso",
                                        nomeTreino: widget.treinoCompleto.nome,
                                        progress: 0.5,
                                        progressColor: Color(0xFF04959A),
                                        leftAmount: 50,
                                        width: screenWidth * 0.28,
                                        screenWidth: screenWidth,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            title: Text("Anterior"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text("Informações"),
          ),
          BottomNavigationBarItem(
            icon: !validaUltimoExercicio
                ? Icon(Icons.arrow_forward)
                : Icon(Icons.assistant_photo_outlined),
            title: !validaUltimoExercicio
                ? Text("Próximo")
                : Text("Finaliza Treino"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  _feedbackPage(UsuarioTreinoModel usuarioTreino, String tempoExecucaoTreino) {
    // Modular.to.pushNamedAndRemoveUntil('/feedbackPage', (_) => false);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => FeedbackPage()));
    // Modular.to.pushNamed('/feedbackPage', arguments: {
    //   'treinoCompleto': widget.treinoCompleto,
    //   'usuarioTreino': usuarioTreino,
    //   'tempoExecucaoTreino': tempoExecucaoTreino,
    // });

    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return FeedbackPage(
    //     treinoCompleto: widget.treinoCompleto,
    //     usuarioTreino: usuarioTreino,
    //     tempoExecucaoTreino: tempoExecucaoTreino,
    //   );
    // }));

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackPage(
            treinoCompleto: widget.treinoCompleto,
            usuarioTreino: usuarioTreino,
            tempoExecucaoTreino: tempoExecucaoTreino,
          ),
        ),
        (route) => false);
  }

  Widget _carregaVideo() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildVideoPlayer(
              "https://homapi.workout365.com.br/public/api/exercicios/videos/streaming/${widget.treinoCompleto.exercicios_treino[step].exercicio_id}");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildVideoPlayer(String urlVideo) {
    Video video = Video(url: urlVideo);

    return BlocProvider<VideoPlayerBloc>(
      create: (context) => VideoPlayerBloc(
          RepositoryProvider.of<VideoControllerService>(context))
        ..add(VideoSelectedEvent(video)),
      child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[_getPlayer(context, state)],
          );
        },
      ),
    );
  }

  Widget _getPlayer(BuildContext context, VideoPlayerState state) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenWidth / ASPECT_RATIO;

    if (state is VideoPlayerStateLoaded) {
      return VideoPlayerWidget(
        key: Key(state.video.url),
        controller: state.controller,
      );
    }

    if (state is VideoPlayerStateError) {
      return Container(
        height: containerHeight,
        color: Colors.black,
        child: Center(
          child: Text(state.message),
        ),
      );
    }

    return Container(
      height: containerHeight,
      color: Colors.black,
      child: Center(
        child: Text('Initialising video...'),
      ),
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

  Widget _finalizarTreino(context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Finalizar Treino"),
          content: Text("Deseja realmente finalizar a execução do treino?"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Não"),
            ),
            FlatButton(
              onPressed: () async {
                _startStopButtonPressed();
                var usuarioTreinoFinal = UsuarioTreinoModel();
                usuarioTreinoFinal = await feedbackTreino(
                  widget.treinoCompleto,
                  _stopWatch.elapsed.inSeconds.toString(),
                );
                _feedbackPage(usuarioTreinoFinal,
                    _stopWatch.elapsed.inMinutes.toString());
              },
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  Widget _series(TreinoCompletoModel treinoCompleto, int index) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 15, right: 5),
      height: 100.0,
      width: 150,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Colors.black,
        elevation: 2.0,
        child: Container(
          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
          height: 115.0,
          width: 75.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10 Rep.",
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 2.0,
                        width: 75,
                        color: Color(0xFF04959A),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Carga: 100%",
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

  Future<UsuarioTreinoModel> feedbackTreino(
      TreinoCompletoModel treinoCompleto, String tempoTotalTreino) async {
    String datafimTreino =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    return await treinoFreeServices.enviarFimDoTreino(
        widget.usuarioTreino, datafimTreino, tempoTotalTreino);
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final String nomeTreino;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;
  final double screenWidth;

  const _IngredientProgress(
      {Key key,
      this.ingredient,
      this.nomeTreino,
      this.leftAmount,
      this.progress,
      this.progressColor,
      this.width,
      this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          ingredient,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: screenWidth * 0.92 - 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 10,
                  width: (screenWidth * 0.92 - 80) * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "${leftAmount}% ",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
