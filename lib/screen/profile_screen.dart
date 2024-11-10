import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('INI PROFILE SCREEN'),
      ),
    );
  }
}