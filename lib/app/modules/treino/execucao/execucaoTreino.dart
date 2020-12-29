import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:video_player/video_player.dart';
import 'package:workout365app/app/core/theme_workout365.dart';
import 'package:workout365app/app/core/viewmodels/rest_viewmodel.dart';
import 'package:workout365app/app/models/exercicios_treino_model.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/usuario_treino_model.dart';
import 'package:workout365app/app/modules/treino/feedback/feedbackPage.dart';
import 'package:workout365app/app/modules/treino/home/inicioTreino.dart';
import 'package:workout365app/app/modules/video/blocs/video_player/video_player_bloc.dart';
import 'package:workout365app/app/modules/video/blocs/video_player/video_player_event.dart';
import 'package:workout365app/app/modules/video/blocs/video_player/video_player_state.dart';
import 'package:workout365app/app/modules/video/models/video.dart';
import 'package:workout365app/app/modules/video/services/video_controller_service.dart';
import 'package:workout365app/app/modules/video/widgets/video_player_widget.dart';
import 'package:workout365app/app/services/treino_free_services.dart';
import 'package:workout365app/app/shared/components/next_step.dart';
import 'package:workout365app/app/shared/theme_utils.dart';

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

class _ExecucaoTreinoState extends State<ExecucaoTreino>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;
  Future<void> _initializeVideoPlayerFuture;
  var isloaded = false;
  final TreinoFreeServices treinoFreeServices = TreinoFreeServices();

  int step = 0;

  bool _isStart = true;

  String _stopwatchText = '00:00:00';
  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(seconds: 1);
  Timer timer;

  int currentValue = 0;
  Timer timerExercicio;
  bool isStarted = false;
  bool isPaused = false;
  bool validaExercicioPorTempo = false;
  bool validaSerieFinalizada = false;

  void _startTimeout() {
    timer = new Timer(_timeout, _handleTimeout);
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // These are the callbacks
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      setState(() {
        _controller.pause();
      });
    }
  }

  AnimationController rippleController;
  AnimationController scaleController;

  Animation<double> rippleAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    rippleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    scaleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _validaTreinoFinalizado(context, false);
            }
          });

    rippleAnimation =
        Tween<double>(begin: 80.0, end: 90.0).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);

    rippleController.forward();

    if (widget.treinoIniciado) {
      // _startStopButtonPressed();
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
    rippleController.notifyStatusListeners(AnimationStatus.dismissed);
    rippleController.dispose();
    scaleController.notifyStatusListeners(AnimationStatus.dismissed);
    scaleController.dispose();
    _stopWatch.stop();
    timer?.cancel();
    timer = null;
    resetTimer();
    super.dispose();
  }

  var validaUltimoExercicio = false;
  int _selectedIndex = 0;
  int _selectedIndexSerie = 0;
  bool _isSelectedSerie = false;
  var seriesCompletas = [];
  bool exercicioCompleto = false;

  _isSelected(int index) {
    setState(() {
      _selectedIndexSerie = index;
      seriesCompletas.add(index);
      _isSelectedSerie = true;
    });
  }

  _isNotSelected() {
    setState(() {
      _selectedIndexSerie = 0;
      _isSelectedSerie = false;
      seriesCompletas = [];
      exercicioCompleto = false;
    });
  }

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
          if (_controller.value.isPlaying) _controller.pause();
          isloaded = false;
          // _controller.dispose();
          _inicializaVideo();
          validaUltimoExercicio = false;
          _isNotSelected();
          _isSelectedSerie = true;
          exercicioCompleto = true;
          var countSerie = 0;
          widget.treinoCompleto.exercicios_treino[step].series
              .forEach((element) {
            seriesCompletas.add(countSerie);
            countSerie++;
          });
        }
      });
    }
    if (index == 2 && exercicioCompleto) {
      resetTimer();
      setState(() {
        if (step == widget.treinoCompleto.exercicios_treino.length - 1 &&
            validaUltimoExercicio) {
          _finalizarTreino(context);
        }
        if (step < (widget.treinoCompleto.exercicios_treino.length - 1)) {
          step++;
          if (step == widget.treinoCompleto.exercicios_treino.length - 1) {
            validaUltimoExercicio = true;
          }
          if (_controller.value.isPlaying) _controller.pause();
          isloaded = false;
          // _controller.dispose();
          _inicializaVideo();
          _isNotSelected();
        }
      });
    } else if (index == 2 && !exercicioCompleto) {
      _validaTreinoFinalizado(context, validaUltimoExercicio);
    }
    if (index == 1) {
      _mostrarModal(context, widget.treinoCompleto);
    }
  }

  var countItemList = 0;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(widget.treinoCompleto.nome),
      //   elevation: 0.0,
      //   centerTitle: true,
      //   backgroundColor: Color(0xFF414550),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 5),
        child: Stack(
          children: <Widget>[
            Container(
              height: screenHeight + 75,
              width: screenWidth,
              color: Colors.white,
            ),
            SwipeDetector(
              onSwipeLeft: () {
                setState(() {
                  if (step <
                      (widget.treinoCompleto.exercicios_treino.length - 1)) {
                    step++;
                    if (_controller.value.isPlaying) _controller.pause();
                    isloaded = false;
                    // _controller.dispose();
                    _inicializaVideo();
                  }
                });
              },
              onSwipeRight: () {
                setState(() {
                  if (step >= 1) {
                    step--;
                    if (_controller.value.isPlaying) _controller.pause();
                    // _controller.dispose();
                    isloaded = false;
                    _inicializaVideo();
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    height: statusBarHeight,
                    width: screenWidth,
                    color: Color(0xFF04959A),
                  ),
                  Container(
                    height: (screenHeight / 2) - 65,
                    width: screenWidth,
                    child: _carregaVideo(),
                  ),
                ],
              ),
            ),
            Positioned(
              top: (screenHeight * 0.36) - 240,
              child: Container(
                height: screenHeight / 2 + 60,
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 50.0),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0XFFA4B2AE)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isloaded
                ? Positioned(
                    top: (screenHeight * 0.36) - 75 + statusBarHeight,
                    right: (screenHeight * 0.1) - 190,
                    child: Container(
                      height: screenHeight / 2 + 60,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedBuilder(
                              animation: rippleAnimation,
                              builder: (context, child) => Container(
                                width: rippleAnimation.value,
                                height: rippleAnimation.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF04959A).withOpacity(.4)),
                                  child: InkWell(
                                    onTap: () {
                                      if (!isStarted && !isPaused) {
                                        _iniciaTimerExercicio(context);
                                      } else if (isStarted) {
                                        pauseTimer();
                                      } else if (!isStarted && isPaused) {
                                        unpauseTimer();
                                      }
                                      // _startTimer();
                                    },
                                    child: AnimatedBuilder(
                                      animation: scaleAnimation,
                                      builder: (context, child) =>
                                          Transform.scale(
                                        scale: scaleAnimation.value,
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF04959A),
                                          ),
                                          child: Center(
                                            child: !isStarted
                                                ? Text(
                                                    "START",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.pause,
                                                    size: 35,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            widget.treinoCompleto.exercicios_treino[step].forma_execucao
                        .descricao ==
                    "Tempo"
                ? Positioned(
                    top: (screenHeight * 0.36) + 24 + statusBarHeight,
                    child: Container(
                      height: screenHeight / 2 + 60,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              FAProgressBar(
                                currentValue: currentValue,
                                maxValue: widget
                                    .treinoCompleto
                                    .exercicios_treino[step]
                                    .tempo_execucao_por_serie_segundos,
                                borderRadius: 1,
                                size: 85,
                                progressColor: Color(0xff6A994E),
                                backgroundColor:
                                    Color(0xff6A994E).withOpacity(0.4),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (widget.treinoCompleto.exercicios_treino[step]
                                                  .tempo_execucao_por_serie_segundos -
                                              currentValue)
                                          .toString() +
                                      's',
                                  style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
            Positioned(
              top: (screenHeight * 0.36) + 100 + statusBarHeight,
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 10, right: 8),
                height: screenHeight / 2 + 100,
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount:
                                widget.treinoCompleto.exercicios_treino.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  index == 0
                                      ? Row(
                                          children: [
                                            Text(
                                              "1 de 3",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.0,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  _card(widget.treinoCompleto, index, size,
                                      screenWidth, screenHeight),
                                  Divider(
                                    thickness: 1,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      height: 153.0,
                      width: screenWidth * 0.92,
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Colors.black,
                        elevation: 2.0,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 20),
                          height: 160.0,
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
                                        progress: (((step + 1) * 100.0) /
                                                    widget
                                                        .treinoCompleto
                                                        .exercicios_treino
                                                        .length)
                                                .toInt()
                                                .toDouble() /
                                            100,
                                        progressColor: Color(0xFF04959A),
                                        leftAmount: (((step + 1) * 100.0) /
                                                widget.treinoCompleto
                                                    .exercicios_treino.length)
                                            .toInt(),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.arrow_back),
      //       title: Text("Anterior"),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.info_outline),
      //       title: Text("Informações"),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: !validaUltimoExercicio
      //           ? Icon(Icons.arrow_forward)
      //           : Icon(Icons.assistant_photo_outlined),
      //       title: !validaUltimoExercicio
      //           ? Text("Próximo")
      //           : Text("Finalizar Treino"),
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.black,
      //   onTap: _onItemTapped,
      // ),
    );
  }

  Widget _card(TreinoCompletoModel treinoCompleto, int index, Size size,
      double screenWidth, double screenHeight) {
    return Container(
      height: 60.0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              countItemList == index ? _carregaProgressBar() : Container(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        treinoCompleto.exercicios_treino[index].exercicio.nome,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 2.0,
                      width: 150,
                      color: Color(0xFF04959A),
                    ),
                    SizedBox(height: 5),
                    Text(
                      countItemList == index
                          ? (widget.treinoCompleto.exercicios_treino[step]
                                      .tempo_execucao_por_serie_segundos -
                                  currentValue)
                              .toString()
                          : widget.treinoCompleto.exercicios_treino[step]
                              .tempo_execucao_por_serie,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Color(0xFF04959A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _carregaProgressBar() {
    return FAProgressBar(
      currentValue: currentValue,
      maxValue: widget.treinoCompleto.exercicios_treino[step]
          .tempo_execucao_por_serie_segundos,
      borderRadius: 1,
      size: 60,
      progressColor: Color(0xff6A994E).withOpacity(0.1),
      backgroundColor: Colors.transparent,
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
          // return _buildVideoPlayer(
          //     "https://api.workout365.com.br/public/api/exercicios/videos/streaming/${widget.treinoCompleto.exercicios_treino[step].exercicio_id}");
          return AspectRatio(
            aspectRatio: isloaded ? _controller?.value?.aspectRatio : 16 / 9,
            // Use the VideoPlayer widget to display the video.
            child: Stack(children: [
              isloaded
                  ? VideoPlayer(_controller)
                  : Center(
                      child: Image.asset('lib/assets/images/logoNovaPreto.png'),
                    ),
            ]),
          );
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
        child: Text('Carregando vídeo...'),
      ),
    );
  }

  Future<void> _inicializaVideo() async {
    if (mounted) {
      await _disposeVideoController();
    }
    _controller = VideoPlayerController.network(
        "https://homapi.workout365.com.br/public/api/exercicios/videos/streaming/${widget.treinoCompleto.exercicios_treino[step].exercicio_id}");
    print(_controller.dataSource.toString());
    _controller.addListener(() {
      print('Listener');
      if (!_controller.value.isPlaying && !_controller.value.isBuffering) {
        setState(() {
          isloaded = false;
        });
      }
    });
    _controller.setLooping(true);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {
        if (step == 0 && !_stopWatch.isRunning) _startStopButtonPressed();
        isloaded = true;
      });
    });
    Timer(Duration(seconds: 2), () {
      _controller.play();
    });
    // _controller.seekTo(Duration(seconds: 1));
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
                                height: 15.0,
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
                                widget.treinoCompleto?.exercicios_treino[step]
                                            .exercicio?.descricao !=
                                        null
                                    ? widget
                                        .treinoCompleto
                                        ?.exercicios_treino[step]
                                        .exercicio
                                        ?.descricao
                                    : widget
                                        .treinoCompleto
                                        ?.exercicios_treino[step]
                                        .exercicio
                                        ?.nome,
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
                              SizedBox(height: 10.0),
                              Text(
                                "Grupo Muscular: ${treinoCompleto.exercicios_treino[step].exercicio.grupos_musculares.map((grupo) => grupo)}",
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
                                margin: EdgeInsets.only(top: 60),
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
                _feedbackPage(
                    usuarioTreinoFinal,
                    _stopWatch.elapsed.inMinutes.toString() +
                        ':' +
                        _stopWatch.elapsed.inSeconds.toString());
              },
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  Widget _validaTreinoFinalizado(context, bool validaUltimoExercicio) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Próximo Exercício"),
          content: Text(!validaUltimoExercicio
              ? "Para avançar para o próximo exercício você precisa finalizar todas as repetições!"
              : "Para finalizar o treino você precisa realizar todas as repetições!"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  Widget _iniciaTimerExercicio(context) {
    showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
          // Aligns the container to center
          child: Container(
            // A simplified version of dialog.
            width: double.infinity,
            height: 300,
            color: Colors.transparent,
            // child: Text(
            //   (30 - 27).toString() + 's',
            //   style: TextStyle(
            //     fontSize: 100,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.yellowAccent,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            child: FadeAnimatedTextKit(
                duration: Duration(milliseconds: 1000),
                totalRepeatCount: 1,
                text: RestViewModel.countDownTexts,
                textAlign: TextAlign.center,
                onFinished: () {
                  Navigator.pop(context);
                  _startTimer();
                },
                textStyle: TextStyle(
                    fontSize: 150,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent),
                displayFullTextOnTap: true,
                stopPauseOnTap: true),
          ),
        ),
      ),
    );
  }

  Widget _iniciaTimerDescansoEntreSeries(context) {
    var count = 0;
    var descanso = widget.treinoCompleto.exercicios_treino[step]
        .tempo_descando_entre_series_segundos;
    var tempo = List<String>();
    while (count <= descanso) {
      if ((descanso - count) != 0) {
        tempo.add((descanso - count).toString());
      } else {
        tempo.add("GO");
      }
      count++;
    }
    print(tempo);
    showDialog(
      context: context,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
          // Aligns the container to center
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  "Descanse",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                // A simplified version of dialog.
                width: double.infinity,
                height: 300,
                color: Colors.transparent,
                // child: Text(
                //   (30 - 27).toString() + 's',
                //   style: TextStyle(
                //     fontSize: 100,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.yellowAccent,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                child: FadeAnimatedTextKit(
                    duration: Duration(milliseconds: 1000),
                    totalRepeatCount: 1,
                    text: tempo,
                    textAlign: TextAlign.center,
                    onFinished: () {
                      Navigator.pop(context);
                    },
                    textStyle: TextStyle(
                        fontSize: 150,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _series(ExerciciosTreinoModel exercicioTreino, int index) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 15, right: 5),
      height: 90.0,
      width: 120,
      child: Material(
        color: _selectedIndexSerie != null &&
                seriesCompletas.contains(index) &&
                _isSelectedSerie
            ? Colors.orangeAccent
            : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Colors.black,
        elevation: 2.0,
        child: Container(
          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
          height: 110.0,
          width: 75.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            exercicioTreino.forma_execucao.descricao ==
                                    'Repetição'
                                ? exercicioTreino.series[index].repeticoes
                                        .toString() +
                                    ' Rep'
                                : '${exercicioTreino.tempo_execucao_por_serie} min',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          _selectedIndexSerie != null &&
                                  seriesCompletas.contains(index) &&
                                  _isSelectedSerie
                              ? Icon(
                                  Icons.verified_user,
                                  size: 20,
                                  color: Colors.lightGreenAccent,
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 2.0,
                        width: 75,
                        color: Color(0xFF04959A),
                      ),
                      SizedBox(height: 5),
                      Text(
                        exercicioTreino.series[index].carga != null &&
                                exercicioTreino.series[index].carga > 0
                            ? "Carga: ${exercicioTreino.series[index].carga}%"
                            : "Carga: 0",
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

  Future<UsuarioTreinoModel> interromperTreino(
      TreinoCompletoModel treinoCompleto, String tempoTotalTreino) async {
    String datafimTreino =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    return await treinoFreeServices.enviarInterromperTreino(
        widget.usuarioTreino, datafimTreino, tempoTotalTreino);
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  void _startTimer() {
    isStarted = true;

    timerExercicio = new Timer.periodic(new Duration(seconds: 1), (time) {
      setState(() {
        currentValue++;
      });
      // notifyListeners();

      if (currentValue ==
          widget.treinoCompleto.exercicios_treino[step]
              .tempo_execucao_por_serie_segundos) {
        setState(() {
          currentValue = 0;
          if (countItemList == widget.treinoCompleto.exercicios_treino.length) {
            isStarted = false;
          }
          validaSerieFinalizada = true;
          countItemList++;
        });
        print("Exercies Ended!");
        timerExercicio.cancel();
        _startTimer();
      }
    });
  }

  resetTimer() {
    currentValue = 0;
    // notifyListeners();

    if (timerExercicio != null) {
      timerExercicio.cancel();
      timerExercicio = null;
    }
    // _startTimer();
  }

  void pauseTimer() {
    if (timerExercicio != null) timerExercicio.cancel();

    isStarted = false;
    isPaused = true;
  }

  void unpauseTimer() => _startTimer();
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
                  width: screenWidth * 0.92 - 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 10,
                  width: (screenWidth * 0.92 - 85) * progress,
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
