import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/user.dart';
import 'package:vigenesia/screens/index.dart';
import 'package:vigenesia/screens/register.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/utils/helpers.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showFlashMessage();
  }

  void _showFlashMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(args), backgroundColor: AppColors.primary),
        );
      }
    });
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    final response =
        await login(_usernameController.text, _passwordController.text);

    if (response.statusCode == 200) {
      await _saveAndRedirect(response.data as User);
    } else {
      _showErrorMessage(response.message);
      setState(() => _isLoading = false);
    }
  }

  void _showErrorMessage(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message ?? 'Login failed'),
          backgroundColor: AppColors.danger),
    );
  }

  Future<void> _saveAndRedirect(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setInt('userId', user.id ?? 0);

    // Retrieve the arguments passed to the route
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    debugPrint("INI ADALAH ARGUMENTS: ${arguments}");

    if (arguments != null) {
      // You can access the individual values by key
      final currentRoute = arguments['currentRoute'] ?? '/home';
      debugPrint("Current Route: $currentRoute");

      Navigator.of(context).pushReplacementNamed(currentRoute);
    } else {
      // Fallback route if arguments are not passed
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String errorMessage,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      validator: (val) => val!.isEmpty ? errorMessage : null,
      decoration: authInputDecoration(
        hintText,
        prefixIcon: Icon(icon, color: AppColors.primary),
      ),
      obscureText: obscureText,
      cursorColor: AppColors.primary,
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primary,
        ),
        onPressed: _isLoading ? null : () => _attemptLogin(),
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white, strokeWidth: 3)
            : const Text('Masuk', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  void _attemptLogin() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Belum punya akun? ', style: TextStyle(fontSize: 16)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/register');
          },
          child: Text('Daftar',
              style: TextStyle(fontSize: 16, color: AppColors.primary)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Selamat Datang!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Silahkan masuk untuk melanjutkan',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Image.asset('assets/images/login-vector.png', width: 280),
                  const SizedBox(height: 40),
                  _buildTextField(
                    controller: _usernameController,
                    hintText: 'Username atau Email',
                    icon: Icons.person,
                    errorMessage: 'Username atau email tidak boleh kosong',
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    errorMessage: 'Password tidak boleh kosong',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  _buildLoginButton(),
                  const SizedBox(height: 25),
                  _buildRegisterLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
