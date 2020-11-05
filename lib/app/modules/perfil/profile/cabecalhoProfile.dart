import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:workout365app/app/shared/auth_store.dart';

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
                      height: 75,
                      width: 75,
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
                          Modular.get<AuthStore>()
                              .usuarioLogado
                              .nome
                              .split(' ')[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          Modular.get<AuthStore>().usuarioLogado.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          Modular.get<AuthStore>().usuarioLogado.telefone,
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
