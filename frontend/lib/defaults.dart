import 'package:flutter/material.dart';
// This file contains the standard design config used in the app.
// Changes made here will reflect all across the app



//Light Theme
final ThemeData lightTheme = ThemeData(
  fontFamily: 'Satoshi',
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 226, 250, 250), //BG
    onSurface: Color.fromARGB(255, 27, 28, 27), //FG
    primary: Color(0xFF000000), // Primary color for buttons, app bar, etc.
    onPrimary: Color.fromARGB(255, 235, 252, 252), // Color of elements on the primary color (e.g., text on the app bar)
    secondary: Color.fromARGB(255, 184, 205, 205), // Accent color
    onSecondary: Color.fromARGB(142, 11, 17, 16), // Color of elements on the secondary color
  ),
);

//Dark Theme
final ThemeData darkTheme = ThemeData(
  fontFamily: 'Satoshi',
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 27, 28, 27),
    onSurface: Color.fromARGB(255, 226, 250, 250),
    primary: Color.fromARGB(255, 235, 252, 252), // Primary color for buttons, app bar, etc.
    onPrimary: Color(0xFF000000),
    secondary: Color.fromARGB(255, 45, 48, 47), // Accent color
    onSecondary: Color.fromARGB(255, 197, 219, 219),
  )
);

//-------------------------AppColors (LIGHT_THEME)

const Color surfaceLight = Color.fromARGB(255, 226, 252, 252); // BG
const Color onSurfaceLight = Color(0xFF121212); // FG
const Color primaryLight = Color(0xFF000000); // Primary color for buttons, app bar, etc.
const Color onPrimaryLight = Color(0xFFFAFAFA);
const Color secondaryLight = Color(0xFFBDBDBD);
const Color onSecondaryLight = Color(0xFF000000);

//------------------------Fonts
const String defaultFontFamily = 'Satoshi';
