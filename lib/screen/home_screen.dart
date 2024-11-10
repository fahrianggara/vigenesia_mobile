import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vigenesia/components/categories.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      init: homeController,
      builder: (controller) => SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Categories(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}