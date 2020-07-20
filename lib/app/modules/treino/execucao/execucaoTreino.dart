import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ExecucaoTreino extends StatefulWidget {
  @override
  _ExecucaoTreinoState createState() => _ExecucaoTreinoState();
}

class _ExecucaoTreinoState extends State<ExecucaoTreino> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.white,
          ),
          Container(
            height: screenHeight - screenHeight / 2,
            width: screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/Remada.gif'),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            top: screenHeight - screenHeight / 2 - 25.0,
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
                  Text("Remada Unilateral",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w500)),
                  SizedBox(height: 7.0),
                  Text("4x15 repetições",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5E5B54),
                      )),
                  SizedBox(height: 7.0),
                  Row(
                    children: <Widget>[
                      SmoothStarRating(
                          allowHalfRating: false,
                          starCount: 5,
                          rating: 3.0,
                          size: 15.0,
                          color: Color(0XFF04959A),
                          borderColor: Color(0XFF04959A),
                          spacing: 0.0),
                      SizedBox(width: 3.0),
                      Text("3.0",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF04959A),
                          )),
                      SizedBox(width: 3.0),
                      Text("Média",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFFC2C0B6),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Grupo Muscular: Tríceps",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XDD201F1C)),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Descrição Completa",
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
                onTap: () {},
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
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0, top: 50.0),
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0XFFA4B2AE)),
                child: Center(
                  child: Icon(
                    Icons.favorite_border,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight / 2 - 25.0,
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
          )
        ],
      ),
    );
  }
}
