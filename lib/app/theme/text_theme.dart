import 'dart:ui';

import 'package:flutter/material.dart';

TextTheme getTextTheme() {
  return const TextTheme(
    titleSmall: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
    // bodyMedium: TextStyle(fontWeight: FontWeight.w500),
    labelLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
    ),

    // for appbar title
    titleLarge: TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    // labelSmall: TextStyle()
    // titleSmall: TextStyle(fontWeight: FontWeight.bold),
    // headlineMedium: TextStyle(color: Colors.white)
  );
}
