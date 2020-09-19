import 'package:flutter/material.dart';

class CardProximoTreino extends StatelessWidget {
  const CardProximoTreino({
    Key key,
    this.image,
    this.modulo,
    this.titulo,
    this.size,
    this.press,
  }) : super(key: key);

  final Size size;
  final String image, titulo, modulo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: size.width,
      padding: EdgeInsets.only(
        right: 15,
        left: 15,
        bottom: 15,
      ),
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
                margin: EdgeInsets.only(left: 10),
                height: 75.0,
                width: 75.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: AssetImage("lib/assets/images/k365.png"),
                      fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        "SEU PRÓXIMO TREINO",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        titulo,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 2.0,
                      width: size.width - 150,
                      color: Color(0xFF04959A),
                    ),
                    SizedBox(height: 5.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$modulo\n",
                            style: TextStyle(
                              color: Color(0xFF04959A).withOpacity(0.5),
                            ),
                          ),
                          TextSpan(
                            text: "Musculação",
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
            ],
          ),
        ),
      ),
    );
  }
}
