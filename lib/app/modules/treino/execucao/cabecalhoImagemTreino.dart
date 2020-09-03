import 'dart:io';

import 'package:flutter/material.dart';

class CabecalhoImagemTreino extends StatelessWidget {
  const CabecalhoImagemTreino({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 2,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("lib/assets/images/Remada.gif"),
              ),
            ),
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
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
