import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.deepPurple[700],
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.grey[50], // Fundo suave
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple[700],
        elevation: 4, // Sombras para dar destaque
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurpleAccent[200],
        elevation: 8, // Sombra suave
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        buttonColor: Colors.deepPurpleAccent[100],
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // Remove a borda padrão
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent[200]!),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.deepPurple[900], fontSize: 28, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.deepPurple[700], fontSize: 16),
        bodyText2: TextStyle(color: Colors.grey[700], fontSize: 14),
      ),
      cardTheme: CardTheme(
        elevation: 6,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.deepPurple[200], // Cor das sombras
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.deepPurple[400],
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}