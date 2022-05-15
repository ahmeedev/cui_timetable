import 'dart:ui';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme(context) {
  final base = ThemeData.light();
  return ThemeData(
      brightness: Brightness.light,
      splashColor: shadowColor,
      dividerColor: Colors.transparent,
      scaffoldBackgroundColor: scaffoldColor,
      colorScheme: base.colorScheme.copyWith(secondary: primaryColor),
      // primaryColor: swatch,
      // drawerTheme: DrawerThemeData(backgroundColor: Colors.red),
      fontFamily: 'Lato',
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color(0xff173962)),
      ),
      textTheme: const TextTheme(
        titleMedium:
            TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),

        // labelSmall: TextStyle()
        // titleLarge: TextStyle(
        //     fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        // titleSmall: TextStyle(fontWeight: FontWeight.bold),
        // bodyMedium: TextStyle(color: Colors.black),
        // headlineMedium: TextStyle(color: Colors.white)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: primaryColor)));
}
