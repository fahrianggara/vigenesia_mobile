import 'package:flutter/material.dart';
import 'package:vigenesia/screens/login.dart';
import 'package:vigenesia/controller/user_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            logout().then((val) => {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false,
              )
            });
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
