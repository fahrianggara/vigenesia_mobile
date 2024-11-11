import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class AddpostScreen extends StatelessWidget {
  const AddpostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HALAMAN BUAT POSTINGAN'),
      ),
    );
  }
}