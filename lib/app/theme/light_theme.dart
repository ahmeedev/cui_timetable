import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme(context) {
  final base = ThemeData.light();
  return ThemeData(
      brightness: Brightness.light,
      // primaryColor: swatch,
      // drawerTheme: DrawerThemeData(backgroundColor: Colors.red),
      colorScheme: base.colorScheme.copyWith(secondary: primaryColor),
      fontFamily: 'Lato',
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color(0xff173962)),
      ),
      textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
          titleLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          titleMedium:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          titleSmall: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: primaryColor)));
}
