import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/category_controller.dart';
import 'package:vigenesia/models/category.dart';
import 'package:vigenesia/utils/colors.dart';

class FetchCategories extends StatelessWidget {
  FetchCategories({super.key});

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    // Panggil fetchCategories() saat widget diinisialisasi
    categoryController.fetchCategories();

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 37,
                // Gunakan Obx untuk memantau perubahan `isLoading` di controller
                child: Obx(() {
                  return getCategories(categoryController.categories);
                }),
              )
            ],
          ),
        )
      ],
    );
  }
}

Widget getCategories(List<Category> categories) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      bool isLastItem = index == (categories.length - 1);
      return Container(
        margin: EdgeInsets.only(
            left: index == 0 ? 20 : 10, right: isLastItem ? 20 : 0),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: HexColor('#000000').withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            '${categories[index].name} (${categories[index].postsCount})',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    },
  );
}
