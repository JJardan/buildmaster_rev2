import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

ThemeData basicThemeData(BuildContext context) {
  return ThemeData(
    textTheme: GoogleFonts.ubuntuTextTheme(
      Theme.of(context).textTheme.copyWith(
        displayLarge: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.red),
        displayMedium: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.yellow),
        displaySmall: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.pink),
        headlineLarge: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.purple),
        headlineMedium: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.greenAccent),
        headlineSmall: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.redAccent),
        titleLarge: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic,color: Colors.black),
        titleMedium: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.black),
        titleSmall: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.black),
        bodyLarge: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.normal,color: Colors.blue),
        bodyMedium: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.normal,color: Colors.blueAccent),
        bodySmall: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.normal,color: Colors.lightBlue),
        labelLarge: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.lightBlueAccent),
        labelMedium: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.deepOrange),
        labelSmall: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,color: Colors.deepPurple),
      ),
    ),
    focusColor: Colors.teal,

    appBarTheme: const AppBarTheme(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: false,
        foregroundColor: Colors.black,
        elevation: 0.5),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 5,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.deepPurple),

    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(background: Color.fromRGBO(246, 246, 255, 1),),

    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle()
    )
  );
}