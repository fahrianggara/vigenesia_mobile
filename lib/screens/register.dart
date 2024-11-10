import 'package:flutter/material.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/user.dart';
import 'package:vigenesia/screens/login.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/utils/constant.dart';
import 'package:vigenesia/utils/helpers.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController 
      _nameController = TextEditingController(),
      _usernameController = TextEditingController(),
      _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _passwordConfirmController = TextEditingController();
  final UserController userController = Get.put(UserController());

  void _register() async 
  {
    ApiResponse response = await userController.register(
      _nameController.text,
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
      _passwordConfirmController.text,
    );

    if (response.statusCode == 201) {
      _saveAndRedirect(response.data as User);
    } 
    
    else {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
        backgroundColor: response.statusCode == 201 ? AppColors.primary : AppColors.danger,
      ));
    }
  }

  void _saveAndRedirect(User user) async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Login(),
        settings: const RouteSettings(
          arguments: "Akun kamu berhasil dibuat, silahkan login."
        ),
      ), (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Daftar ke $appName!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Ayo daftar dan buat akunmu sekarang!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 35),

                        // image
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset(
                            'assets/images/register-vector.png',
                            width: 260,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // email field
                        TextFormField(
                          controller: _nameController,
                          validator: (val) => val!.isEmpty ? "Nama tidak boleh kosong" : null,
                          decoration: authInputDecoration(
                            'Nama',
                            prefixIcon: Icon(Icons.person_2, color: AppColors.primary),
                            errorText: _formKey.currentState?.validate() == false
                                ? 'Nama tidak boleh kosong'
                                : null,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // email field
                        TextFormField(
                          controller: _usernameController,
                          validator: (val) => val!.isEmpty ? "Username tidak boleh kosong" : null,
                          decoration: authInputDecoration(
                            'Username',
                            prefixIcon: Icon(Icons.person, color: AppColors.primary),
                            errorText: _formKey.currentState?.validate() == false
                                ? 'Username tidak boleh kosong'
                                : null,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // email field
                        TextFormField(
                          controller: _emailController,
                          validator: (val) =>
                              val!.isEmpty ? "Email tidak boleh kosong" : null,
                          decoration: authInputDecoration(
                            'Email',
                            prefixIcon: Icon(Icons.email, color: AppColors.primary),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        // password field
                        TextFormField(
                          controller: _passwordController,
                          validator: (val) => val!.length < 6
                              ? "Password minimal 6 karakter"
                              : null,
                          decoration: authInputDecoration(
                            'Password',
                            prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                            errorText: _formKey.currentState?.validate() == false
                                ? 'Password tidak boleh kosong'
                                : null,
                          ),
                          obscureText: true,
                        ),

                        const SizedBox(height: 20),

                        // confirm password field
                        TextFormField(
                          controller: _passwordConfirmController,
                          validator: (val) => val != _passwordController.text
                              ? "Konfirmasi password tidak sama"
                              : null,
                          decoration: authInputDecoration(
                            'Konfirmasi Password',
                            prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                            errorText: _formKey.currentState?.validate() == false
                                ? 'Konfirmasi password tidak sama'
                                : null,
                          ),
                          obscureText: true,
                        ),

                        const SizedBox(height: 20),

                        // register button with maximum width
                        // login button with maximum width
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: AppColors.white,
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                  _register();
                                });
                              }
                            },
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Text('Daftar', style: TextStyle(fontSize: 16)),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // register link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sudah punya akun? ',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed('/login');
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                      ]
                    ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
