import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Colors.indigo;
  static const Color secondaryColor = Color.fromARGB(255, 114, 105, 216);
  static const Color accentColor = Colors.blueAccent;
  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.yellow;
  static const Color dangerColor = Colors.red;
  static const Color infoColor = Colors.blue;

  // Colores de texto
  static const Color primaryTextColor = Color.fromARGB(255, 100, 110, 115);
  static const Color secondaryTextColor = Colors.white;
  static const Color primaryButtonTextColor = Colors.white;

  // Color de fondo
  static const Color backgroundColor = Color.fromARGB(255, 215, 220, 225);

  // Fuente por defecto
  static TextStyle fontFamily = GoogleFonts.poppins();

  static ThemeData getAppTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: getColorSwatch(primaryColor),
        accentColor: accentColor,
        backgroundColor: backgroundColor,
      ),
      useMaterial3: true,
      // Otros ajustes de tema aquí
    );
  }

  static MaterialColor getColorSwatch(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color,
      600: color.withOpacity(0.6),
      700: color.withOpacity(0.7),
      800: color.withOpacity(0.8),
      900: color.withOpacity(0.9),
    });
  }
}
