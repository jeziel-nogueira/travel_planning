import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Tema Claro
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.purple, // Cor primária
    secondaryHeaderColor: Colors.black54, // Cor secundária
    scaffoldBackgroundColor: Color(0xFFb1e1e9), // Cor de fundo
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Cor de texto principal
      bodyMedium: TextStyle(color: Colors.grey),  // Cor de texto secundário
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF96d7eb),
      titleTextStyle: TextStyle(color: Colors.black54, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.red),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF839cb5)), // Cor de ícones
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF839cb5) // Cor do FAB
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF686466), // Cor primária
      secondary: Color(0xFF839cb5), // Cor secundária
      tertiary: Color(0xFF686466), // Cor terciária
    ),
  );

  // Tema Escuro
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900], // Cor primária
    secondaryHeaderColor: Colors.grey[700], // Cor secundária
    scaffoldBackgroundColor: Color(0xFF686466), // Cor de fundo
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // Cor de texto principal
      bodyMedium: TextStyle(color: Colors.grey),  // Cor de texto secundário
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF839cb5),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF96d7eb)), // Cor de ícones
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.grey, // Cor do FAB
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF96d7eb), // Cor primária
      secondary: Color(0xFF96d7eb), // Cor secundária
      tertiary: Colors.grey[600]!, // Cor terciária
    ),
  );
}
