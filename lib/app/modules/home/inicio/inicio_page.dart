import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:workout365app/app/modules/loja/loja_page.dart';

class Inicio_Page extends StatefulWidget {
  @override
  _Inicio_PageState createState() => _Inicio_PageState();
}

class _Inicio_PageState extends State<Inicio_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 250.0,
                color: Colors.white70
              ),
              Column(
                children: <Widget>[
                    Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(15.0, 35, 15.0, 5.0),
                    child: Text("Bem Vindo Rafael",
                      style: TextStyle(
                          fontFamily: 'Timesroman',
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15.0, bottom: 10),
                    child:
                    Text("Você ainda não possui um módulo de treino ativo",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey,
                          fontSize: 14.0
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Container(
                          height: 275.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(image: AssetImage("lib/assets/images/Costas2.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30.0, left: 200.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Nível Iniciante",
                              style: TextStyle(
                                  fontFamily: 'Timesroman',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  color: Colors.black
                              ),
                            ),
                            Text("Módulo 1",
                              style: TextStyle(
                                  fontFamily: 'Timesroman',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.grey
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              height: 3.0,
                              width: 50.0,
                              color: Color(0xFF04959A),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border(left: BorderSide(
                              color: Color(0xFF04959A),
                              style: BorderStyle.solid,
                              width: 3.0
                          ))
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Treinos Gratuítos', style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Timesroman',
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0),
                    height: 125.0,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        _card(),
                        SizedBox(width: 10.0),
                        _card2(),
                        SizedBox(width: 10.0),
                        _card(),
                        SizedBox(width: 10.0),
                        _card2(),

                      ],
                    ),

                  ),

                ],
              )
            ],
          ),
          SizedBox( height: 15.0,),
          Container(
              padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Color(0xFF04959A),
                      color: Color(0xFF04959A),
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: (){
                       
                        },
                        child: Center(
                          child: Text(
                            'Acessar Loja de Treinos',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              )),
        ],
      ),

    );
  }

  Widget _card(){
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
              image: DecorationImage(image: AssetImage("lib/assets/images/triceps.jpg"),
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
              Text('Aquecimento', style: TextStyle(
                fontFamily: 'Quicksand',
              ),),
              Text('15 min', style: TextStyle(
                fontFamily: 'Quicksand',
              ),),
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
                      child: 
                      SmoothStarRating(
                          allowHalfRating: false,
                          starCount: 5,
                          rating: 3.0,
                          size: 15.0,
                          color: Color(0XFF04959A),
                          borderColor: Color(0XFF04959A),
                          spacing: 0.0
                      ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _card2(){
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
              image: DecorationImage(image: AssetImage("lib/assets/images/apoio.jpg"),
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
              Text('Apoio', style: TextStyle(
                fontFamily: 'Quicksand',
              ),),
              Text('20 min', style: TextStyle(
                fontFamily: 'Quicksand',
              ),),
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
                    child: 
                      SmoothStarRating(
                          allowHalfRating: false,
                          starCount: 5,
                          rating: 5.0,
                          size: 15.0,
                          color: Color(0XFF04959A),
                          borderColor: Color(0XFF04959A),
                          spacing: 0.0
                      ),
                  ),


                ],
              )
            ],
          )
        ],
      ),
    );
  }
}