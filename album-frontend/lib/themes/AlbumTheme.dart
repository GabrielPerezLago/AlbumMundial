
import 'package:flutter/material.dart';

class AlbumTheme {
  static final ThemeData LIGHT = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.red,
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'Bowlby',
      bodyColor: Colors.black
    ),
    scaffoldBackgroundColor: Color(0xCDFF0D3E),
    inputDecorationTheme: InputDecorationTheme( border: OutlineInputBorder(),),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent.shade100,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20)
        )
      )
    )

  );

  static final ThemeData DARK = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'Bowlby'
    ),
    scaffoldBackgroundColor: Color(0xCD700017), // Rojo Oscuro
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: Brightness.dark
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20)
        )
      )
    )
  );
}