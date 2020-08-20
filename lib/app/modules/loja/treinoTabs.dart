import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TreinoTab extends StatefulWidget {
  @override
  _TreinoTabState createState() => _TreinoTabState();
}

class _TreinoTabState extends State<TreinoTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/k365.png', size),
          _buildListItem('Trieno de Abdominais', 4.0, '6',
              'lib/assets/images/k365.png', size),
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/k365.png', size),
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/k365.png', size),
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/k365.png', size),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _buildListItem(
      String treinoNome, rating, String preco, String imgPath, Size size) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: size.width - 30,
            height: 100,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.black,
              elevation: 2.0,
              child: GestureDetector(
                onTap: () {
                  // _iniciarTreino();
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 75.0,
                      width: 75.0,
                      child: Center(
                        child: Image.asset(imgPath, height: 50.0, width: 50.0),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              treinoNome,
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            height: 2.0,
                            width: 75.0,
                            color: Color(0xFF04959A),
                          ),
                          SizedBox(height: 5.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "8 Exercícios\n",
                                  style: TextStyle(
                                    color: Color(0xFF04959A).withOpacity(0.5),
                                  ),
                                ),
                                TextSpan(
                                  text: "R\$ $preco",
                                  style: TextStyle(
                                    color: Color(0xFF04959A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: FloatingActionButton(
                        heroTag: treinoNome,
                        mini: true,
                        onPressed: () {},
                        child: Center(
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Color(0xFF04959A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
