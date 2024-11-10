import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('INI LOGIN SCREEN'),
      ),
    );
  }
}