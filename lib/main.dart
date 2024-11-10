import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:vigenesia/routes/mobile_route.dart';
import 'package:vigenesia/screen/home_screen.dart';
import 'package:vigenesia/utils/utilities.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        scaffoldBackgroundColor: VColors.background,
      ),
      home: const HomeScreen(),
      getPages: MobileRoute.pages,
    );
  }
}
