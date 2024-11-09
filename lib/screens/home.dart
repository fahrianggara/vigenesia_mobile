import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia/components/categories/fetch.dart';
import 'package:vigenesia/components/posts/carousel.dart';
import 'package:vigenesia/components/posts/fetch.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());

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
              FetchCategories(),
              PostsCarousel(),
              Posts(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
