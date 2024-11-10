import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigenesia/routes/app_route.dart';
import 'package:vigenesia/utils/utilities.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRoute();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        scaffoldBackgroundColor: VColors.background,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
