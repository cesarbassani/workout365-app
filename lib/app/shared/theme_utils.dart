import 'package:flutter/material.dart';

class ThemeUtils {
  static Color primaryColor;
  static Color primaryColorDark;
  static Color primaryColorLight;
  static Color accentColor;
  static ThemeData theme;

  static void init(BuildContext context) {
    theme = Theme.of(context);
    primaryColor = Theme.of(context).primaryColor;
    primaryColorDark = Theme.of(context).primaryColorDark;
    primaryColorLight = Theme.of(context).primaryColorLight;
    accentColor = Theme.of(context).accentColor;
  }
}
