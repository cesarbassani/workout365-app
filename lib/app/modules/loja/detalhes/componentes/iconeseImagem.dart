import 'package:flutter/material.dart';

import 'cardIcones.dart';


class IconeseImagem extends StatelessWidget {
  const IconeseImagem({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: SizedBox(
        height: size.height * 0.8,
                child: Row(children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60 ),
              child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                    child: IconButton(
                    padding: EdgeInsets.symmetric(horizontal:  20),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black),
                  ),
                ),
                Spacer(),
                CardIcone(),
                CardIcone(),
                CardIcone(),
                CardIcone(),
             ] ,),
            ),
          ),
          Container(
            height: size.height * 0.8,
            width: size.width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(63),
                bottomLeft: Radius.circular(63)
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius:60,
                  color: Color(0xFF414550).withOpacity(0.29) 
                ),
              ],
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                fit: BoxFit.cover,
                image: AssetImage("lib/assets/images/Costas2.jpg"),
                 )
              ),
          ),
        ],),
      ),
    );
  }
}
