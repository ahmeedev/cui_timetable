import 'package:flutter/material.dart';

const primaryColor = Color(0xFF265FA4);
const secondaryColor = Color(0xFF482369);
const forGradient = Color(0XFF1b4373);
const scaffoldColor = Color(0xffd4dfed);
const onScaffoldColor = Color(0xffD1E6FF);
const shadowColor = Color(0Xffd4dfed);
// const scaffoldColor = Color(0xffD8E8FC);
const widgetColor = Color(0xffe9eff6);
// const widgetColor = Color(0xffEBF4FF);
const textFieldColor = Color(0xffbecfe4);
const selectionColor = Color(0xff93afd2);
const expandedColor = Color(0xff93afd2);
const successColor = Color(0xff028c5a);
const successColor2 = Color(0xff02734a);
// const errorColor1 = Color(0xff800000);
const errorColor1 = Color(0xffB00020);

const primaryGradient = [primaryColor, forGradient];
const successGradient = [successColor, successColor2];
const errorGradient = [Color(0xff800000), Color(0xff990000)];

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
