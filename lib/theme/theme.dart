import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigenesia/utils/utilities.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.rubik().fontFamily,
  colorScheme: lightColorScheme,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: VColors.text),
  )
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.rubik().fontFamily,
  colorScheme: darkColorScheme,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: VColors.white),
  )
);