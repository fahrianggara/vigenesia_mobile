import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia/components/categories/fetch.dart';
import 'package:vigenesia/components/posts/carousel.dart';
import 'package:vigenesia/components/posts/fetch.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/utils/constant.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());
  int _selectedIndex = 0;

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
        body: GetBuilder<HomeController>(
          init: homeController,
          builder: (controller) => SmartRefresher(
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
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
