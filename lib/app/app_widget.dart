import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:workout365app/app/core/theme_workout365.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Modular.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Workout365',
      theme: ThemeWorkout365.theme(),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
