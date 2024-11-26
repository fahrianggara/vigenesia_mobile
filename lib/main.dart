import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigenesia/routes/app_route.dart';
import 'package:vigenesia/theme/theme_provider.dart';
import 'package:vigenesia/utils/utilities.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), 
      child: MainApp()
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRoute();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      title: appName,
      routerConfig: _appRouter.config(),
    );
  }
}
