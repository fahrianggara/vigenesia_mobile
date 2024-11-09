import 'package:flutter/material.dart';
import 'package:vigenesia/screens/index.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _redirectToHome();
  }

  // Fungsi untuk langsung mengarahkan ke halaman Home setelah sedikit jeda
  void _redirectToHome() async {
    await Future.delayed(const Duration(seconds: 1)); // Delay singkat
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Index()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: CircularProgressIndicator(), // Indikator loading
      ),
    );
  }
}
