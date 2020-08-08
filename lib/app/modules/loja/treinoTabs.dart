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
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/Costas2.jpg'),
          _buildListItem('Trieno de Abdominais', 4.0, '6',
              'lib/assets/images/Abdominal.jpg'),
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/Costas2.jpg'),
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/Costas2.jpg'),
          _buildListItem(
              'Trieno de Costas', 4.0, '6', 'lib/assets/images/Costas2.jpg'),
        ],
      ),
    );
  }

  _buildListItem(String treinoNome, rating, String preco, String imgPath) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 300.0,
            child: Row(
              children: <Widget>[
                Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Color(0xFF04959A),
                  ),
                  child: Center(
                    child: Image.asset(imgPath, height: 50.0, width: 50.0),
                  ),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      treinoNome,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      // onRatingChanged: (v) {},
                      starCount: rating.toInt(),
                      rating: rating,
                      color: Color(0xFFFFD143),
                      borderColor: Color(0xFFFFD143),
                      size: 15.0,
                      spacing: 0.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'R\$' + preco,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFF68D7F)),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          FloatingActionButton(
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
          )
        ],
      ),
    );
  }
}
