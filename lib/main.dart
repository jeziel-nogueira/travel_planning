import 'package:flutter/material.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/themes/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLightTheme = true; // Controle do tema

  void toggleTheme() {
    setState(() {
      isLightTheme = !isLightTheme; // Alterna o tema
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isLightTheme ? AppTheme.lightTheme : AppTheme.darkTheme, // Tema baseado no estado
      home: HomeScreen(
        isLightTheme: isLightTheme, // Passa a informação do tema
        toggleTheme: toggleTheme,   // Função para alternar o tema
      ),
    );
  }
}
