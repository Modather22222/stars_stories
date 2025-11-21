import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFEF3349);
  static const Color darkText = Color(0xFF17181A);
  static const Color greyText = Color(0xFF808080);
  static const Color background = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.elMessiriTextTheme().apply(
        bodyColor: darkText,
        displayColor: darkText,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        surface: background,
      ),
      useMaterial3: true,
    );
  }
}
