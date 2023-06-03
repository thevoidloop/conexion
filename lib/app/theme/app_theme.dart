import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData.dark().copyWith(
      primaryColorLight: Colors.amber.shade300,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: Colors.black45)));
}
