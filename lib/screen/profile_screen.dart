import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !authController.isLoggedIn.value ? _screenNoAuth(context) :
        Center(child: Text("KAMU SUDAH LOGIN"))
    );
  }

  Widget _screenNoAuth(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.vectorAuth,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            'Hmm.. belum login?',
            style: TextStyle(fontSize: 18, color: VColors.primary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Sepertinya kamu belum login nih.. Silahkan login terlebih dahulu ya.',
            style: TextStyle(fontSize: 16, color: VColors.gray),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.pushRoute(LoginRoute()); // Navigate to login
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              backgroundColor: VColors.primary,
              foregroundColor: VColors.primary50
            ),
            child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
