import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigenesia/screens/index.dart';
import 'package:vigenesia/screens/loading.dart';
import 'package:vigenesia/screens/login.dart';
import 'package:vigenesia/screens/posts/create.dart';
import 'package:vigenesia/screens/register.dart';
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
      // Define your routes here
      initialRoute: '/',  // Starting route (home or login screen)
      routes: {
        '/': (context) => Home(),  // or your initial screen, like PostCreate
        '/login': (context) => Login(),  // Define the login route
        '/register' : (context) => Register(),
        '/post/create' : (context) => PostCreate()
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes (if any)
        return MaterialPageRoute(builder: (context) => Home());
      },
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        scaffoldBackgroundColor: AppColors.background,
      ),
    );
  }
}
