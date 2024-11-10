import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/screens/home.dart';
import 'package:vigenesia/screens/profile.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/utils/constant.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> 
{
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _selectedIndex == 0 || _selectedIndex == 1 ? appBar() : null,
        body: _selectedIndex == 2 ? Profile() : Home(),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      title: Text(
        appName,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bottomBar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });

        if (index == 1) {
          // Navigasi ke layar `PostCreate` dan kembali ke indeks utama setelahnya
          Navigator.pushNamed(context,'/post/create').then((_) {
            // Kembali ke Home setelah PostCreate ditutup
            setState(() {
              _selectedIndex = 0;
            });
          });
        }
      },
      backgroundColor: HexColor('#FFFFFF'),
      indicatorColor: AppColors.primary100,
      destinations: <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home, color: _selectedIndex == 0 ? AppColors.primary : HexColor('#B0B0B0')),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.add, color: _selectedIndex == 1 ? AppColors.primary : HexColor('#B0B0B0')),
          label: 'Tambah',
        ),
        NavigationDestination(
          icon: Icon(Icons.person, color: _selectedIndex == 2 ? AppColors.primary : HexColor('#B0B0B0')),
          label: 'Profile',
        ),
      ],
    );
  }
}

