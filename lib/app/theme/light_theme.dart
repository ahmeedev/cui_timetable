import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/theme/text_theme.dart';

ThemeData lightTheme(context, {required isLarge}) {
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
      cardTheme: CardTheme(
          color: widgetColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.defaultRadius))),
          elevation: Constants.defaultElevation,
          shadowColor: shadowColor),
      textTheme: getTextTheme(scaleFactor: isLarge ? 0.0 : 3.0),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: primaryColor)));
}
