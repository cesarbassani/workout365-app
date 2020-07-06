import 'package:flutter/material.dart';
class CardsModulosRecomendados extends StatelessWidget {
  const CardsModulosRecomendados({
    Key key,
    this.image,
    this.modulo,
    this.titulo,
    this.preco,
    this.size,
    this.press,
  }) : super(key: key);

  final Size size;
  final String image, titulo, modulo;
  final int preco;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        top: 20/2,
        bottom: 20 * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
           Image.asset(image),
           GestureDetector(
             onTap: press,
              child: Container(
               padding: EdgeInsets.all(20 / 2),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(10),
                   bottomRight: Radius.circular(10),
                 ),
                 boxShadow: [
                   BoxShadow(
                     offset: Offset(0,10),
                     blurRadius: 50,
                     color: Color(0xFF414550).withOpacity(0.23),
                   )
                 ]
               ),
               child: Row(
                 children: <Widget>[
                   RichText(
                     text: TextSpan(
                       children: [
                         TextSpan(text: "$titulo\n".toUpperCase(),
                         style: Theme.of(context).textTheme.button,
                         ),
                         TextSpan(
                           text: "$modulo",
                           style: TextStyle(color: Color(0xFF04959A).withOpacity(0.5))
                         )
                       ]
                       ),
                   ),
                   Spacer(),
                   Text(
                     'R\$ $preco',
                     style: Theme.of(context).textTheme.button.copyWith(color: Color(0xFF04959A)),
                   )

               ],) ,
             ),
           )
        ],
      ),
    );
  }
}