import 'package:flutter/material.dart';
import 'package:vigenesia/screens/loading.dart';

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
        fontFamily: 'Inter',
      ),
    );
  }
}
