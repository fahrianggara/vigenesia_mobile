import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> 
{
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    authController.onInit();  // Ensure onInit is called
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(() { // Wrap with Obx to listen for changes to isLoggedIn
        return !authController.isLoggedIn.value
            ? _screenNoAuth(context)
            : _screenAuth(context);
      }),
    );
  }

  // Screen for logged-in users
  Widget _screenAuth(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add your profile content here, for example:
          Text(
            'Welcome, User!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Call the logout function from the controller
              authController.logout(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              backgroundColor: VColors.primary,
              foregroundColor: VColors.primary50,
            ),
            child: Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  // Screen for users who are not logged in
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
              foregroundColor: VColors.primary50,
            ),
            child: Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
