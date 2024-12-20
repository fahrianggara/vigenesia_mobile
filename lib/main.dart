import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vigenesia/routes/app_route.dart';
import 'package:vigenesia/theme/theme.dart';
import 'package:vigenesia/theme/theme_provider.dart';
import 'package:vigenesia/utils/utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      title: appName,
      routerConfig: _appRouter.config(),
    );
  }
}

