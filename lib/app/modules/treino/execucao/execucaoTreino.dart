import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:video_player/video_player.dart';
import 'package:workout365app/app/models/exercicios_treino_model.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';

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
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('lib/assets/images/Remada.gif'),
//                fit: BoxFit.cover,
//              ),
//            ),
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
                      widget.treinoCompleto.exercicios_treino[step].exercicio
                          .nome,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w500)),
                  SizedBox(height: 7.0),
                  Text(
                      widget
                          .treinoCompleto.exercicios_treino[step].numero_series
                          .toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5E5B54),
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Grupo Muscular: ${widget.treinoCompleto.grupos_muculares.map((grupo) => grupo)}",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XDD201F1C)),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    widget.treinoCompleto.exercicios_treino[step].exercicio
                        .descricao,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF04959A)),
                  ),
                  SizedBox(height: 10.0),
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
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 75.0,
              width: 100.0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (step >= 1) {
                        step--;
                        _inicializaVideo();
                      }
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "<",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        "Anterior",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30.0)),
                  color: Color(0xFF414550)),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 75.0,
              width: 100.0,
              child: Center(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (step <
                        (widget.treinoCompleto.exercicios_treino.length - 1)) {
                      step++;
                      _inicializaVideo();
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      ">",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      "Próximo",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              )),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30.0)),
                  color: Color(0xFF414550)),
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
          Positioned(
            top: screenHeight / 2,
            right: 15.0,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 50.0),
              child: Container(
                height: 40.0,
                width: 40.0,
                child: GestureDetector(
                  onTap: () {
                    _mostrarModal(context);
                  },
                  child: Center(
                    child: Icon(
                      Icons.info_outline,
                      size: 30.0,
                      color: Color(0XFF04959A),
                    ),
                  ),
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

  void _mostrarModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("texto"),
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
