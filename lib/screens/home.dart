import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/components/categories/fetch.dart';
import 'package:vigenesia/components/posts/carousel.dart';
import 'package:vigenesia/components/posts/fetch.dart';
import 'package:vigenesia/controller/category_controller.dart';
import 'package:vigenesia/controller/post_controller.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/utils/constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Fungsi untuk memuat ulang data
  Future<void> _refreshData() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            appName,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData, // Fungsi yang dipanggil saat melakukan pull-to-refresh
          child: SingleChildScrollView(
            child: Column(
              children: [
                FetchCategories(),
                PostsCarousel(),
                Posts(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: HexColor('#FFFFFF'),
          indicatorColor: AppColors.primary100,
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0
                      ? AppColors.primary
                      : HexColor('#B0B0B0')),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.add,
                  color: _selectedIndex == 1
                      ? AppColors.primary
                      : HexColor('#B0B0B0')),
              label: 'Tambah',
            ),
            NavigationDestination(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 2
                      ? AppColors.primary
                      : HexColor('#B0B0B0')),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
