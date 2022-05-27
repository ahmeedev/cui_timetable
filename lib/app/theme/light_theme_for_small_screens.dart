import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightThemeForSmallScreens(context) {
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
      textTheme: getTextTheme(scaleFactor: 3),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: primaryColor)));
}
