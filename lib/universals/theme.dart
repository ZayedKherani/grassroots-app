import 'package:flutter/material.dart';
import 'package:grassroots_app/universals/variables.dart';

ThemeData? lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffb2ac88),
    onPrimary: Color(0xff738678),
    secondary: Color(0xff738678),
    onSecondary: Color(0xffb2ac88),
    error: Color(0xffff0000),
    onError: Color(0xffffa500),
    background: Color(0xffffffff),
    onBackground: Color(0xfff5f5f5),
    surface: Color(0xff738678),
    onSurface: Color(0xffb2ac88),
  ),
  platform: appTargetPlatform!,
);

ThemeData? darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff738678),
    onPrimary: Color(0xffb2ac88),
    secondary: Color(0xffb2ac88),
    onSecondary: Color(0xff738678),
    error: Color(0xffff0000),
    onError: Color(0xffffa500),
    background: Color(0xff000000),
    onBackground: Color(0xff0a0a0a),
    surface: Color(0xffb2ac88),
    onSurface: Color(0xff738678),
  ),
  platform: appTargetPlatform!,
);
