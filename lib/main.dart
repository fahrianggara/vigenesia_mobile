import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigenesia/screens/loading.dart';
import 'package:vigenesia/utils/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Loading(),
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        scaffoldBackgroundColor: AppColors.background,
      ),
    );
  }
}
