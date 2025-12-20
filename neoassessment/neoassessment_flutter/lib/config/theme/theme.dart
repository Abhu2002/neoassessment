import 'package:flutter/material.dart';
import 'dart:io' show Platform;



final ThemeData appTheme = ThemeData(

  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    primary: Colors.green,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'MerriweatherBlackItalic',
        fontSize: 62,
        color: Colors.white),
    titleLarge: TextStyle(
      fontFamily: 'MerriweatherRegular',
      fontSize: 30,
      fontStyle: FontStyle.italic,
    ),
    titleMedium: TextStyle(
      fontFamily: "MerriweatherRegular",
      fontSize: 22,
      color: Colors.black,
      // fontWeight: FontWeight.bold
    ),
    titleSmall: TextStyle(
        fontFamily: "MerriweatherRegular", fontSize: 18, color: Colors.black),
    headlineMedium: TextStyle(
      fontFamily: "MerriweatherRegular",
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
        fontFamily: "MerriweatherRegular",
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black),
    bodyLarge: TextStyle(
      fontFamily: "MerriweatherRegular",
      fontSize: 24,
    ),
    bodyMedium: TextStyle(
      fontFamily: "MerriweatherRegular",
      fontSize: 15,
    ),
    displaySmall: TextStyle(
      fontFamily: "MerriweatherRegular",
      fontSize: 10,
      color: Colors.lightGreen,
    ),
  ),
);
