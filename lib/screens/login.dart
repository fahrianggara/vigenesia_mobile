import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/user.dart';
import 'package:vigenesia/screens/home.dart';
import 'package:vigenesia/screens/register.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/utils/helpers.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> 
{
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Periksa apakah ada pesan flash dari halaman sebelumnya
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is String) {
        // Tampilkan pesan flash menggunakan ScaffoldMessenger
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(args),
          backgroundColor: AppColors.primary, // warna untuk berhasil
        ));
      }
    });
  }

  void _login() async 
  { 
    ApiResponse response = await login(_usernameController.text, _passwordController.text);
    
    if (response.statusCode == 200) {
      _saveAndRedirect(response.data as User);
    } 
    
    else {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
        backgroundColor: AppColors.danger,
      ));
    }
  }

  void _saveAndRedirect(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setInt('userId', user.id ?? 0);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false,
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
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Silahkan masuk untuk melanjutkan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // image
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          'assets/images/login-vector.png',
                          width: 280,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // username field
                      TextFormField(
                        controller: _usernameController,
                        validator: (val) => val!.isEmpty
                            ? 'Username atau email tidak boleh kosong'
                            : null,
                        decoration: authInputDecoration(
                          'Username atau Email',
                          prefixIcon: Icon(Icons.person, color: AppColors.primary),
                          errorText: _formKey.currentState?.validate() == false
                              ? 'Username atau email tidak boleh kosong'
                              : null,
                        ),
                        cursorColor: AppColors.primary,
                      ),

                      const SizedBox(height: 20),

                      // password field
                      TextFormField(
                        controller: _passwordController,
                        validator: (val) =>
                            val!.isEmpty ? 'Password tidak boleh kosong' : null,
                        decoration: authInputDecoration(
                          'Password',
                          prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                          errorText: _formKey.currentState?.validate() == false
                              ? 'Password tidak boleh kosong'
                              : null,
                        ),
                        obscureText: true,
                        cursorColor: AppColors.primary,
                      ),

                      const SizedBox(height: 20),

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
                              });

                              _login();
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
                              : const Text('Masuk', style: TextStyle(fontSize: 16)),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Belum punya akun? ',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Register()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primary,
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
        ),
      ),
    );
  }
}
