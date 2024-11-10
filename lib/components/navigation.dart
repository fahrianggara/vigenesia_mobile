import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:auto_route/auto_route.dart';

Widget bottomNavigationBar(TabsRouter tabsRouter) {
  return SizedBox(
    height: 70.0, // Set the desired height here
    child: BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      backgroundColor: HexColor('#FFFFFF'),
      onTap: tabsRouter.setActiveIndex,
      selectedItemColor: VColors.primary,
      selectedFontSize: 12,
      elevation: 2,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: tabsRouter.activeIndex == 0 ? VColors.primary : VColors.border500,
          ),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: tabsRouter.activeIndex == 1 ? VColors.primary : VColors.border500,
          ),
          label: 'Tambah',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: tabsRouter.activeIndex == 2 ? VColors.primary : VColors.border500,
          ),
          label: 'Profile',
        ),
      ],
    ),
  );
}