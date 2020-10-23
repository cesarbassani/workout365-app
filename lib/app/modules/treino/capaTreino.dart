import 'package:flutter/material.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';

class CapaTreino extends StatelessWidget {
  const CapaTreino({
    Key key,
    @required this.size,
    @required this.treinoCompleto,
  }) : super(key: key);

  final Size size;
  final TreinoCompletoModel treinoCompleto;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.4,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.4 - 50,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("lib/assets/images/barra.jpg"))),
            child: Align(
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
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: size.width * 0.9,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 50,
                      color: Color(0XFF12153D).withOpacity(0.2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.timer,
                        size: 28,
                        color: Colors.black38,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black38),
                            children: [
                              TextSpan(
                                  text: treinoCompleto.tempo_total_por_treino
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ]),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.fitness_center,
                        size: 28,
                        color: Colors.black38,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black38),
                            children: [
                              TextSpan(
                                  text: treinoCompleto.equipamentos.length
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ]),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.repeat,
                        size: 28,
                        color: Colors.black38,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black38),
                            children: [
                              TextSpan(
                                  text: treinoCompleto.tipo,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ]),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black38),
                            children: [
                              TextSpan(
                                text: treinoCompleto
                                    .quantidade_exercicios_treino
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black38),
                            children: [
                              TextSpan(
                                text: "Exercícios",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //SafeArea(child: BackButton()),
        ],
      ),
    );
  }
}
