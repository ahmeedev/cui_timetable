import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFF265FA4);
const secondaryColor = Color(0xFF482369);
const defaultPadding = 10.0;
const iconSize = 25.0;
ThemeData lightTheme(context) {
  return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Lato',
      textTheme: const TextTheme(
          // AppBar
          titleLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          bodyMedium: TextStyle(color: Colors.red),
          labelMedium: TextStyle(fontWeight: FontWeight.bold)),
      snackBarTheme: SnackBarThemeData(backgroundColor: Colors.red));
}
