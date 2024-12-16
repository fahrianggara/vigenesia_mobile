import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/components/widget.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final TextEditingController 
      _nameController = TextEditingController(),
      _usernameController = TextEditingController(),
      _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _passwordConfirmController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: VColors.background,
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

                  const SizedBox(height: 20),
                  Text(
                    'Daftar ke $appName',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: VColors.primary,
                      letterSpacing: 0.1,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    'Ayo daftar dan buat akunmu sekarang!',
                    style: TextStyle(
                      fontSize: 16,
                      color: VColors.border500,
                      letterSpacing: 0.1,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  Image.asset(Images.vectorRegis, width: 260),

                  const SizedBox(height: 30),

                  buildTextField(
                    context,
                    controller: _nameController,
                    hintText: 'Nama',
                    icon: Icons.person,
                    errorMessage: 'Nama tidak boleh kosong',
                  ),

                  const SizedBox(height: 20),

                  buildTextField(
                    context,
                    controller: _usernameController,
                    hintText: 'Username',
                    icon: Icons.person,
                    errorMessage: 'Username tidak boleh kosong',
                  ),

                  const SizedBox(height: 20),

                  buildTextField(
                    context,
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.email,
                    errorMessage: 'Email tidak boleh kosong',
                    keyboardType: TextInputType.emailAddress
                  ),

                  const SizedBox(height: 20),

                  buildTextField(
                    context,
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    errorMessage: 'Password tidak boleh kosong',
                    obscureText: _obscureText,
                    validator: (val) => val!.length < 8 
                      ? "Password minimal 8 karakter"
                      : null,
                    suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
                    onSuffixTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  buildTextField(
                    context,
                    controller: _passwordConfirmController,
                    hintText: 'Konfirmasi Password',
                    icon: Icons.lock,
                    errorMessage: 'Konfirmasi Password tidak boleh kosong',
                    obscureText: _obscureText,
                    validator: (val) => val != _passwordController.text
                      ? "Konfirmasi password tidak sama"
                      : null,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: VColors.white,
                        backgroundColor: VColors.primary,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authController.register(
                            context,
                            _nameController,
                            _usernameController,
                            _emailController,
                            _passwordController,
                            _passwordConfirmController
                          );
                        }
                      },
                      child: Obx(() => authController.isLoading.value
                        ? loadingIcon()
                        : const Text('Daftar', style: TextStyle(fontSize: 16))
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? ', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          context.navigateTo(LoginRoute());
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: VColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }
}
