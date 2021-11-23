import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Color.fromARGB(255, 4, 125, 141),
  appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 4, 125, 141)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 4, 125, 141))
    )
  ),
);