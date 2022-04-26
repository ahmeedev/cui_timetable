import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFF265FA4);
const secondaryColor = Color(0xFF482369);
const forGradient = Color(0XFF1b4373);
const shadowColor = Color(0Xffd4dfed);
const scaffoldColor = Color(0xffd4dfed);
const widgetColor = Color(0xffe9eff6);
const textFieldColor = Color(0xffbecfe4);
const selectionColor = Color(0xff93afd2);
const successColor = Color(0xff028c5a);
const successColor2 = Color(0xff02734a);

const defaultPadding = 10.0;
const defaultRadius = 10.0;
const defaultElevation = 10.0;
const iconSize = 25.0;

const swatch = MaterialColor(
  0xFF265FA4, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(0xff265fa4), //10%
    100: Color(0xff225694), //20%
    200: Color(0xff1e4c83), //30%
    300: Color(0xff1b4373), //40%
    400: Color(0xff173962), //50%
    500: Color(0xff133052), //60%
    600: Color(0xff0f2642), //70%
    700: Color(0xff0b1c31), //80%
    800: Color(0xff081321), //90%
    900: Color(0xff040910), //100%
  },
);

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
