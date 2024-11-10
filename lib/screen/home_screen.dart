import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/utils/utilities.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Center(child: Text('ini adalah home'))
        ),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: VColors.white,
      title: Text(
        appName,
        style: TextStyle(
          color: VColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bottomBar() {
    return NavigationBar(
      backgroundColor: HexColor('#FFFFFF'),
      indicatorColor: VColors.primary100,
      destinations: <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home, color: VColors.primary),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.add, color: VColors.border500),
          label: 'Tambah',
        ),
        NavigationDestination(
          icon: Icon(Icons.person, color: VColors.border500),
          label: 'Profile',
        ),
      ],
    );
  }
}
