import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/assinatura/creditCard/cardInformation.dart';
import 'package:workout365app/app/modules/assinatura/pricePage/beneficiosTab.dart';
import 'package:workout365app/app/modules/assinatura/pricePage/sobreTab.dart';

class PriceInformation extends StatefulWidget {
  @override
  _PriceInformationState createState() => _PriceInformationState();
}

class _PriceInformationState extends State<PriceInformation> {
  _procederParaPagamento() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CardInformation()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Workout 365"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xFF414550),
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 15.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 300.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: AssetImage(
                                  'lib/assets/images/logoGrande.png'),
                              fit: BoxFit.fitWidth,
                            )),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Assinatura Workout 365",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "R\$ 29,00",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          child: Text('Treinos Personalizados'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                              )),
                          child: Text('Níveis'),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    Material(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      child: TabBar(
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Color(0xFF04959A),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        tabs: [
                          Tab(text: "Benefícios"),
                          Tab(text: "Sobre"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    BeneficiosTab(),
                    SobreTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          padding: EdgeInsets.only(left: 18.0, bottom: 25.0, right: 18.0),
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(Icons.fitness_center, color: Colors.black),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: SizedBox(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      _procederParaPagamento();
                    },
                    color: Color(0xFF04959A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      "Assinar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
