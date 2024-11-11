import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:auto_route/auto_route.dart';

Widget bottomNavigationBar(TabsRouter tabsRouter) {
  return Container(
    height: 60.0, // Tentukan tinggi bar
    decoration: BoxDecoration(
      color: HexColor('#FFFFFF'),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Home Icon
        bottomNavIcon(
          icon: Icons.home,
          isActive: tabsRouter.activeIndex == 0,
          onTap: () => tabsRouter.setActiveIndex(0),
        ),
        // Search Icon
        bottomNavIcon(
          icon: Icons.search_sharp,
          isActive: tabsRouter.activeIndex == 1,
          onTap: () => tabsRouter.setActiveIndex(1),
        ),
        // Profile Icon
        bottomNavIcon(
          icon: Icons.person,
          isActive: tabsRouter.activeIndex == 2,
          onTap: () => tabsRouter.setActiveIndex(2),
        ),
      ],
    ),
  );
}

Widget bottomNavIcon({
  required IconData icon,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: isActive ? VColors.primary.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(10), // Border radius persegi panjang
          ),
          child: Icon(
            icon,
            color: isActive ? VColors.primary : VColors.border500,
            size: 28, // Ukuran ikon
          ),
        ),// Menambahkan jarak antara ikon dan teks jika aktif
      ],
    ),
  );
}
