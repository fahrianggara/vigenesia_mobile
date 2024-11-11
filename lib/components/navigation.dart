import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Import the flutter_svg package
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
          asset: Images.svgHome,  // Specify the SVG file path
          isActive: tabsRouter.activeIndex == 0,
          onTap: () => tabsRouter.setActiveIndex(0),
        ),
        // Search Icon
        bottomNavIcon(
          asset: Images.svgSearch,  // Specify the SVG file path
          isActive: tabsRouter.activeIndex == 1,
          onTap: () => tabsRouter.setActiveIndex(1),
        ),
        // Profile Icon
        bottomNavIcon(
          asset: Images.svgProfile,  // Specify the SVG file path
          isActive: tabsRouter.activeIndex == 2,
          onTap: () => tabsRouter.setActiveIndex(2),
        ),
      ],
    ),
  );
}

Widget bottomNavIcon({
  required String asset,  // Changed to accept an SVG asset path
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
          child: SvgPicture.string(
            asset,  // Load the SVG asset
            colorFilter: ColorFilter.mode(
              isActive ? VColors.primary : VColors.border500,  // Apply different color based on active state
              BlendMode.srcIn,
            ),
            height: 22, // Set the height for the SVG
          ),
        ),
      ],
    ),
  );
}
