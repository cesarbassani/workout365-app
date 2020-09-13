import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:workout365app/app/models/exercicios_treino_model.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/modules/treino/feedback/feedbackPage.dart';

class ExecucaoTreino extends StatefulWidget {
  final TreinoCompletoModel treinoCompleto;

  const ExecucaoTreino({Key key, this.treinoCompleto}) : super(key: key);

  @override
  _ExecucaoTreinoState createState() => _ExecucaoTreinoState();
}

class _ExecucaoTreinoState extends State<ExecucaoTreino> {
  _feedbackPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FeedbackPage()));
  }

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
            height: screenHeight / 2 - 20,
            width: screenWidth,
            child: _carregaVideo(),
          ),
          Positioned(
            top: screenHeight / 2 - 40,
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
                  SizedBox(height: 10),
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
                    height: 120.0,
                    width: screenWidth,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.treinoCompleto.exercicios_treino[step]
                            .numero_series,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _series(widget.treinoCompleto, index),
                            ],
                          );
                        }),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight / 2 - 120.0,
            right: 25.0,
            child: Hero(
              tag: "k365",
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
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              child: Container(
                height: 75.0,
                width: 100.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '>',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Próximo',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30.0)),
                  color: Color(0xFF414550),
                ),
              ),
              onTap: () {
                setState(() {
                  if (step <
                      (widget.treinoCompleto.exercicios_treino.length - 1)) {
                    step++;
                    _inicializaVideo();
                  }
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              child: Container(
                height: 75.0,
                width: 100.0,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        '<',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Anterior',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ])),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                  ),
                  color: Color(0xFF414550),
                ),
              ),
              onTap: () {
                setState(() {
                  if (step >= 1) {
                    step--;
                    _inicializaVideo();
                  }
                });
              },
            ),
          ),
          Positioned(
            bottom: screenHeight / 2 - 400.0,
            left: screenWidth / 2 - 37.5,
            child: GestureDetector(
              child: Container(
                height: 75.0,
                width: 75.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        'Finalizar',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFF04959A),
                ),
              ),
              onTap: () {
                _finalizarTreino(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Container(
                height: 25.0,
                width: 25,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
              ),
              onTap: () {
                setState(() {
                  _mostrarModal(context, widget.treinoCompleto);
                });
              },
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

  Widget _finalizarTreino(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
              onPressed: () {
                _feedbackPage();
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
}
