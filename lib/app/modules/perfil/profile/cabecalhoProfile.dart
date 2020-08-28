import 'package:flutter/material.dart';

class CabecalhoProfile extends StatelessWidget {
  const CabecalhoProfile({
    Key key,
    @required this.size,
    this.mensagemAssinatura,
  }) : super(key: key);

  final Size size;
  final String mensagemAssinatura;

  @override
  Widget build(BuildContext context) {
    // _iniciarTreino() {
    //  Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => InicioTreino()));
    // }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF414550),
                      Color(0xFF18191E),
                    ]),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(36))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: AssetImage(
                            'lib/assets/images/k365.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rafael Leite",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "rafaelbarrosleite@gmail.com",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "(67) 99257-0444",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
