import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout365app/app/modules/assinatura/modulosTreino/cabecalhoModulosTreino.dart';
import 'package:workout365app/app/modules/home/assinante/assinanteHome.dart';
import 'package:workout365app/app/modules/home/home_page.dart';

class ModulosTreino extends StatefulWidget {
  @override
  _ModulosTreinoState createState() => _ModulosTreinoState();
}

class _ModulosTreinoState extends State<ModulosTreino> {
  _paginaInicial() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AssinanteHome()));
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
          children: [
            CabecalhoModulosTreino(
              size: size,
              mensagemAssinatura: "Melhorando sua vida",
            ),
            Text(
              "Tempo de Treino",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5.0),
            Text(
              "6 Meses",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Center(
              child: Container(
                height: size.height / 2 + 20,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          border: Border.all(
                              color: Color(0xFF04959A),
                              style: BorderStyle.solid,
                              width: 1.0), //Gradient
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //Text
                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Container(
                                    child: Text(
                                      'Iniciante',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                //subText
                                Container(
                                  child: Text(
                                    'Módulo de treinos inicial',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                DataTable(
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                  ],
                                  rows: <DataRow>[
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                          FontAwesomeIcons.clock,
                                          "Tempo",
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          '0 a 12',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            FontAwesomeIcons.idCard, "Módulos"),
                                      ),
                                      DataCell(
                                        Text(
                                          '8',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            Icons.fitness_center, "Treinos"),
                                      ),
                                      DataCell(
                                        Text(
                                          '80',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            FontAwesomeIcons.clock, "Duração"),
                                      ),
                                      DataCell(
                                        Text(
                                          '2',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),

                                //Button
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: RaisedButton(
                                      color: new Color(0xffffffff),
                                      child: Text(
                                        'Confirmar',
                                        style: TextStyle(
                                          color: Color(0xFF04959A),
                                        ),
                                      ),
                                      onPressed: () {
                                        _paginaInicial();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Second ListView
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          gradient: LinearGradient(
                            colors: [Color(0xFF198882), Colors.white],
                            begin: Alignment.bottomRight,
                            end: Alignment(1.0, -0.2),
                          ),
                          border: Border.all(
                              color: Color(0xFF04959A),
                              style: BorderStyle.solid,
                              width: 1.0), //Gradient
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //Text
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    child: Text(
                                      'Intermediário',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                //subText
                                Container(
                                  child: Text(
                                    'Módulo de treinos intermediários',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                //Circle Avatar
                                //Two Column Table
                                DataTable(
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                  ],
                                  rows: <DataRow>[
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                          FontAwesomeIcons.clock,
                                          "Tempo",
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          '0 a 12',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            FontAwesomeIcons.idCard, "Módulos"),
                                      ),
                                      DataCell(
                                        Text(
                                          '8',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            Icons.fitness_center, "Treinos"),
                                      ),
                                      DataCell(
                                        Text(
                                          '80',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            FontAwesomeIcons.clock, "Duração"),
                                      ),
                                      DataCell(
                                        Text(
                                          '2',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),

                                //Button
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: RaisedButton(
                                      color: new Color(0xffffffff),
                                      child: Text(
                                        'Confirmar',
                                        style: TextStyle(
                                          color: Color(0xFF04959A),
                                        ),
                                      ),
                                      onPressed: () {
                                        _paginaInicial();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Third ListView
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          gradient: LinearGradient(
                            colors: [Color(0xFF198882), Colors.white],
                            begin: Alignment.bottomRight,
                            end: Alignment(1.0, -1.0),
                          ),
                          border: Border.all(
                              color: Color(0xFF04959A),
                              style: BorderStyle.solid,
                              width: 1.0), //Gradient
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //Text
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    child: Text(
                                      'Avançado',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                //subText
                                Container(
                                  child: Text(
                                    'Módulo de treinos avançados',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                //Two Column Table
                                DataTable(
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                  ],
                                  rows: <DataRow>[
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                          FontAwesomeIcons.clock,
                                          "Tempo",
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          '0 a 12',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            FontAwesomeIcons.idCard, "Módulos"),
                                      ),
                                      DataCell(
                                        Text(
                                          '8',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            Icons.fitness_center, "Treinos"),
                                      ),
                                      DataCell(
                                        Text(
                                          '80',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(
                                        myRowDataIcon(
                                            FontAwesomeIcons.clock, "Duração"),
                                      ),
                                      DataCell(
                                        Text(
                                          '2',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),

                                //Button
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: RaisedButton(
                                      color: new Color(0xffffffff),
                                      child: Text(
                                        'Confirmar',
                                        style: TextStyle(
                                          color: Color(0xFF04959A),
                                        ),
                                      ),
                                      onPressed: () {
                                        _paginaInicial();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ListTile myRowDataIcon(IconData iconVal, String rowVal) {
  return ListTile(
    leading: Icon(iconVal, color: Colors.black),
    title: Text(
      rowVal,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
