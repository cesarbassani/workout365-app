import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/assinatura/modulosTreino/modulosTreino.dart';

import 'cabecalhoPosPagamento.dart';

class ConfirmacaoAssinatura extends StatefulWidget {
  @override
  _ConfirmacaoAssinaturaState createState() => _ConfirmacaoAssinaturaState();
}

class _ConfirmacaoAssinaturaState extends State<ConfirmacaoAssinatura> {
  TextEditingController _controllerTempoTreino = TextEditingController();

  _procederParaPagamento() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ModulosTreino()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout 365"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xFF414550),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(height: 250.0, color: Colors.white70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CabecalhoPosPagamento(
                      size: size,
                      mensagemAssinatura: "Melhorando sua vida",
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "Tempo de Treino",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Para personalizar os treinos de acordo com o seu potencial precisamos primeiro saber há quanto tempo você treina. Por favor informe o tempo em meses",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                        top: 4,
                        left: 16,
                        right: 16,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                            ),
                          ]),
                      child: TextFormField(
                        controller: _controllerTempoTreino,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          icon: Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          hintText: 'Tempo de Treino',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Nome é obrigatório!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 40.0,
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          _procederParaPagamento();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF04959A),
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 10.0),
                              Center(
                                child: Text('Confirmar',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
