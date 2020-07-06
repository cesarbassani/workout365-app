import 'package:flutter/material.dart';


class CardIcone extends StatelessWidget {
  const CardIcone({
    Key key, this.icone,
  }) : super(key: key);

  final String icone;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      padding: EdgeInsets.all(20 / 2),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,15),
            blurRadius: 22,
            color: Color(0xFF04959A).withOpacity(0.22) 
          ),
          BoxShadow(
            offset: Offset(-15,-15),
            blurRadius: 20,
            color: Colors.white 
          )
        ]
        ),
        child: Icon(Icons.home,
        color: Color(0xFF04959A))
        
      );
  }
}