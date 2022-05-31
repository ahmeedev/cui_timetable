// Flutter imports:
import 'package:flutter/material.dart';

TextTheme getTextTheme({required double scaleFactor}) {
  return TextTheme(
    // title
    titleSmall: TextStyle(
        fontSize: 14 - scaleFactor,
        fontWeight: FontWeight.w600,
        color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 16 - scaleFactor,
        fontWeight: FontWeight.w600,
        color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 22 - scaleFactor,
        fontWeight: FontWeight.bold,
        color: Colors.white),

    // body
    bodyMedium: TextStyle(fontSize: 14 - scaleFactor),

    // label
    labelLarge: TextStyle(
      fontSize: 14 - scaleFactor,
      color: Colors.white,
      fontWeight: FontWeight.w900,
    ),
  );
}
