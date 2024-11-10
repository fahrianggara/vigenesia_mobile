import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class PostCreateScreen extends StatelessWidget {
  const PostCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('INI POST CREATE SCREEN'),
      ),
    );
  }
}