import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vigenesia/utils/utilities.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Halaman Pencarian', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: VColors.primary),),
      ),
    );
  }
}