import 'package:credit_card/flutter_credit_card.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/assinatura/posPagamento/confirmacaoAssinatura.dart';

import 'cabecalhoCard.dart';

class CardInformation extends StatefulWidget {
  @override
  _CardInformationState createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void onModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }

  _confirmarPagamento() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ConfirmacaoAssinatura()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF414550),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 100,
                  color: Colors.white70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CabecalhoCard(
                      size: size,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 16, top: 30),
                      child: Text("Preencha as informações para se registrar"),
                    ),
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      height: 200,
                      width: size.width,
                      animationDuration: Duration(milliseconds: 1000),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: CreditCardForm(
                          onCreditCardModelChange: onModelChange,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _confirmarPagamento();
                      },
                      child: Container(
                        height: 40.0,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFF04959A),
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Center(
                              child: Text(
                                'Confirmar Pagamento',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
