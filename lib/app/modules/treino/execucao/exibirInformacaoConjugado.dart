import 'package:flutter/material.dart';

class ExibirInformacaoConjugado extends StatefulWidget {
  @override
  _ExibirInformacaoConjugadoState createState() =>
      _ExibirInformacaoConjugadoState();
}

class _ExibirInformacaoConjugadoState extends State<ExibirInformacaoConjugado> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _mostrarModalConjugado(context);
                },
                child: Container(
                  width: screenWidth / 2,
                  height: 40,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    shadowColor: Colors.black,
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Exercício Conjugado',
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF04959A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _mostrarModalConjugado(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white),
                  child: Container(
                    padding: EdgeInsets.only(top: 12.0, right: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                "Exercício Conjugado",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                height: 3.0,
                                width: 100.0,
                                color: Color(0xFF04959A),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "1/8",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0XFF04959A),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                "Método de Execução Conjugado: \n",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "O usuário deve executar a primeira série de todos os exercícios da lista de conjugados, ao término da lista, retornar ao primeiro exercício e executar a segunda série de todos. Repetir a execução até o final da última série do último exercício da lista  ",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 399,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 60),
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'lib/assets/images/logoGrande.png',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
