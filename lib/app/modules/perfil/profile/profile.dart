import 'package:flutter/material.dart';
import 'package:workout365app/app/modules/perfil/profile/cabecalhoProfile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(height: 250.0, color: Colors.white70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CabecalhoProfile(
                      size: size,
                      mensagemAssinatura: "Melhorando sua vida",
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width - 30,
                            height: 75,
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              elevation: 2.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 75.0,
                                      width: 75.0,
                                      child: Center(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Editar Perfil',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Container(
                                            height: 2.0,
                                            width: 200.0,
                                            color: Color(0xFF04959A),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width - 30,
                            height: 75,
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              elevation: 2.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 75.0,
                                      width: 75.0,
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Alterar Imagem',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Container(
                                            height: 2.0,
                                            width: 200.0,
                                            color: Color(0xFF04959A),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width - 30,
                            height: 75,
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              elevation: 2.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 75.0,
                                      width: 75.0,
                                      child: Center(
                                        child: Icon(
                                          Icons.assignment,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Minhas Medidas',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Container(
                                            height: 2.0,
                                            width: 200.0,
                                            color: Color(0xFF04959A),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width - 30,
                            height: 75,
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.black,
                              elevation: 2.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 75.0,
                                      width: 75.0,
                                      child: Center(
                                        child: Icon(
                                          Icons.fitness_center,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Meus Treinos',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Container(
                                            height: 2.0,
                                            width: 200.0,
                                            color: Color(0xFF04959A),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
