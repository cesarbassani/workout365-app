import 'package:workout365app/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';

class ThemeWorkout365 {
  static theme() {
    return ThemeData(
      primaryColor: Color(0xff6A994E),
      primaryColorDark: Color(0xff599752),
      primaryColorLight: Color(0xffE2F8B7),
      accentColor: Color(0xffA7C957),
      hintColor: Color(0xFF787878),
      fontFamily: 'Quicksand',
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 1.5,
              ),
            ),
      ),
    );
  }
}