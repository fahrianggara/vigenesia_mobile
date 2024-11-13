import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vigenesia/components/carousels.dart';
import 'package:vigenesia/components/categories.dart';
import 'package:vigenesia/components/posts.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:get/get.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return GetBuilder<HomeController>(
      init: homeController,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.onRefresh,  // The refresh logic
        child: SingleChildScrollView(
          child: Column(
            children: [
              Categories(),
              Carousels(),
              Posts(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
