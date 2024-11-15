import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: VColors.primary,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 37,
                child: Obx(() {
                  // Dummy data when `isLoading` is true
                  final categories = homeController.isLoading.value
                      ? List.generate(5, (index) => Category(name: 'Loading...', postsCount: '0'))
                      : homeController.categories;

                  // Wrap `listCategories` with `Skeletonizer` when `isLoading` is true
                  return Skeletonizer(
                    enabled: homeController.isLoading.value,
                    child: listCategories(categories, context),
                  );
                }),
              )
            ],
          ),
        )
      ],
    );
  }
}

// Function to display categories list (or skeleton placeholder when loading)
Widget listCategories(List<Category> categories, BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      bool isLastItem = index == (categories.length - 1);
      return Container(
        margin: EdgeInsets.only(left: index == 0 ? 20 : 10, right: isLastItem ? 20 : 0),
        child: TextButton(
          onPressed: () {
            AutoRouter.of(context);
            context.pushRoute(CategoryShowRoute(id: categories[index].id));
          },
          style: TextButton.styleFrom(
            backgroundColor: HexColor('#000000').withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            '${categories[index].name} (${categories[index].postsCount})',
            style: TextStyle(
              color: VColors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    },
  );
}
