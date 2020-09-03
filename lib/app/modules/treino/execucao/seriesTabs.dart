import 'package:flutter/material.dart';

class SeriesTabs extends StatefulWidget {
  @override
  _SeriesTabsState createState() => _SeriesTabsState();
}

class _SeriesTabsState extends State<SeriesTabs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            "Método de Execução: Padrão",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF5E5B54),
            ),
          ),
          SizedBox(height: 7.0),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    )),
                child: Text('1) 10 Repetições | Carga 100%'),
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
