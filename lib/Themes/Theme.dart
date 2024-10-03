import 'package:flutter/material.dart';

ThemeData LighTheme = ThemeData(
  primarySwatch: Colors.green,
colorScheme: const ColorScheme(brightness: Brightness.light, primary: Colors.green, onPrimary: Colors.white, error: Colors.red, onError: Colors.white, secondary: Colors.greenAccent, onSecondary: Colors.white, surface: Colors.white, onSurface: Colors.black),
  primaryIconTheme: const IconThemeData(
    color: Colors.white,
    size: 28,
  ),
  tabBarTheme: const TabBarTheme(
    dividerColor: Colors.transparent,
    unselectedLabelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white70),
    indicatorColor: Colors.white,
    indicatorSize:TabBarIndicatorSize.tab ,
    labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white)
  ),
    appBarTheme: const AppBarTheme(
      color: Colors.green,

    ),
  iconTheme: const IconThemeData(
    color: Colors.white
  ),

  //theme des elements de type input

  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
    iconColor: Colors.grey,
    prefixIconColor: Colors.grey,
    hintStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.green),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.green),
      borderRadius: BorderRadius.circular(5),
    )
  ),


  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white),
    headlineMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color: Colors.white70),
    headlineSmall: TextStyle(fontSize: 16,color: Colors.grey),
    bodyLarge: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.grey),
  ),
  elevatedButtonTheme:  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      textStyle: const TextStyle(fontSize: 18,color: Colors.white),
    )
  )

);


// theme du mode sombre

ThemeData DarckTheme = ThemeData(
  brightness: Brightness.dark,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white),
      headlineMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color: Colors.white70),
      headlineSmall: TextStyle(fontSize: 16,color: Colors.grey),
      bodyLarge: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.grey),
      bodySmall: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.grey)
    ),

  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
      filled: true,
      fillColor: Colors.black12,
      focusColor: Colors.green,
      hintStyle: const TextStyle(color: Colors.grey,),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.green,),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      )
  ),
  elevatedButtonTheme:  ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.green),
      borderRadius: BorderRadius.circular(10),
    ),
  textStyle: const TextStyle(fontSize: 18,color: Colors.white),
  ),),

  iconTheme: const IconThemeData(
    color: Colors.white
  ),
  tabBarTheme: const TabBarTheme(
    indicatorColor: Colors.green,
    dividerColor: Colors.transparent,
    labelStyle: TextStyle(color: Colors.green,fontSize: 16),
    unselectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 16)
  ),

  appBarTheme: const AppBarTheme(
    centerTitle: true,
  )
);