import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/components/widget.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _usernameController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();
  static final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: VColors.background,
      appBar: appBar(context, title: 'Masuk ke $appName'),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(Images.vectorLogin, width: 280),
                  const SizedBox(height: 40),
                  buildTextField(
                    context,
                    controller: _usernameController,
                    hintText: 'Username atau Email',
                    icon: Icons.person,
                    errorMessage: 'Username atau email tidak boleh kosong',
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    context,
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    errorMessage: 'Password tidak boleh kosong',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  _buildLoginButton(context),
                  const SizedBox(height: 30),
                  _buildRegisterLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: VColors.white,
          backgroundColor: VColors.primary,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            authController.login(
              context,
              _usernameController,
              _passwordController,
            );
          }
        },
        // Observes isLoading to toggle button content
        child: Obx(() => authController.isLoading.value
          ? loadingIcon()
          : const Text('Masuk', style: TextStyle(fontSize: 16))),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Belum punya akun? ', style: TextStyle(fontSize: 16)),
        GestureDetector(
          onTap: () {
            context.pushRoute(const RegisterRoute());
          },
          child: Text(
            'Daftar',
            style: TextStyle(fontSize: 16, color: VColors.primary),
          ),
        ),
      ],
    );
  }
}
