import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('INI REGISTER SCREEN'),
      ),
    );
  }
}