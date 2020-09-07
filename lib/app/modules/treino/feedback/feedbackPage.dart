import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var myFeedbackText = "Bom";
  var sliderValue = 4.0;
  IconData myFeedback = FontAwesomeIcons.smile;
  Color myFeedbackColor = Colors.green;

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
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Treino 04",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                          Text(
                            "Parabéns, você concluiu mais um treino!",
                            style: TextStyle(color: Colors.black38),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: myTextItems("Estimado", "48.6M", size),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Feedback",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Align(
                      child: Material(
                        color: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Container(
                            width: 350.0,
                            height: 400.0,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    child: Text(
                                      myFeedbackText,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Icon(
                                    myFeedback,
                                    color: myFeedbackColor,
                                    size: 100.0,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Slider(
                                      min: 0.0,
                                      max: 5.0,
                                      divisions: 5,
                                      value: sliderValue,
                                      activeColor: Color(0xFF04959A),
                                      inactiveColor: Colors.blueGrey,
                                      onChanged: (newValue) {
                                        setState(() {
                                          sliderValue = newValue;
                                          if (sliderValue >= 0.0 &&
                                              sliderValue <= 1.0) {
                                            myFeedback =
                                                FontAwesomeIcons.sadTear;
                                            myFeedbackColor = Colors.red;
                                            myFeedbackText =
                                                "Poderia ser melhor";
                                          }
                                          if (sliderValue >= 1.1 &&
                                              sliderValue <= 2.0) {
                                            myFeedback = FontAwesomeIcons.frown;
                                            myFeedbackColor = Colors.yellow;
                                            myFeedbackText = "Abaixo da média";
                                          }
                                          if (sliderValue >= 2.1 &&
                                              sliderValue <= 3.0) {
                                            myFeedback = FontAwesomeIcons.meh;
                                            myFeedbackColor = Colors.amber;
                                            myFeedbackText = "Normal";
                                          }
                                          if (sliderValue >= 3.1 &&
                                              sliderValue <= 4.0) {
                                            myFeedback = FontAwesomeIcons.smile;
                                            myFeedbackColor = Colors.green;
                                            myFeedbackText = "Bom";
                                          }
                                          if (sliderValue >= 4.1 &&
                                              sliderValue <= 5.0) {
                                            myFeedback = FontAwesomeIcons.laugh;
                                            myFeedbackColor = Color(0xffff520d);
                                            myFeedbackText = "Excelent";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                      child: Text(
                                    "Sua nota: $sliderValue",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      color: Color(0xFF04959A),
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  )),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container myTextItems(String title, String subtitle, Size size) {
  return Container(
    padding: EdgeInsets.only(left: 5.0),
    height: 100.0,
    width: size.width,
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Colors.black,
      elevation: 2.0,
      child: GestureDetector(
        onTap: () {
          //_iniciarTreino();
        },
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 100.0,
              width: 100.0,
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
                  Flexible(
                    child: Text(
                      "Tempo estimado: 50 min",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 2.0,
                    width: 200.0,
                    color: Color(0xFF04959A),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Tempo de execução: 42 min',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
