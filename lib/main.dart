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
        useMaterial3: true,
        fontFamily: GoogleFonts.rubik().fontFamily,
        colorScheme: lightColorScheme,
        textTheme: TextTheme(
          bodySmall: TextStyle(color: VColors.text),
        )
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.rubik().fontFamily,
        colorScheme: darkColorScheme,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: VColors.white),
        )
      ),
      title: appName,
      routerConfig: _appRouter.config(),
    );
  }
}
