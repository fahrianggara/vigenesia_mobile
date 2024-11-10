import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/auth_controller.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenNoAuth(),
    );
  }

  Widget _screenNoAuth() {
    return Container(
      child: Center(
        child: Text('INI PROFILE SCREEN'),
      ),
    );
  }
}