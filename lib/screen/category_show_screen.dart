import 'package:vigenesia/controller/category_controller.dart';
import 'package:vigenesia/model/category.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/components/widget.dart';

@RoutePage()
class CategoryShowScreen extends StatelessWidget {
  final int? id;
  const CategoryShowScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    // Hapus instance lama (jika ada) sebelum membuat controller baru
    if (Get.isRegistered<CategoryController>()) {
      Get.delete<CategoryController>();
    }

    final CategoryController categoryController = Get.put(CategoryController());

    // Ensure id is not null before fetching the post
    if (id != null) {
      categoryController.getCategory(id!); // Get post by id
    }

    return Obx(() {

      final category = categoryController.category.value;
      
      // Check if category is null
      if (category == null || categoryController.isLoading.value) {
        return categoryIsNull();
      }

      final posts = categoryController.posts;

      return Scaffold(
        appBar: _appBar(
          categoryController,
          category: category,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categoryInfo(categoryController, category: category),
              _categoryPost(categoryController, data: posts),
            ],
          ),
        ),
      );
    });
  }

  Widget _categoryInfo(CategoryController categoryController, {required Category category}) {
    return Skeletonizer(
      enabled: categoryController.isLoading.value,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.background2),
            fit: BoxFit.cover,
          ),
        ),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.name ?? 'Kategori',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.description ?? 'Deskripsi kategori',
              style: TextStyle(
                color: VColors.primary100,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryPost(CategoryController categoryController, {List<Post> data = const []}) {
    return Skeletonizer(
      enabled: categoryController.isLoading.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Ada ${data.length} postingan dalam kategori ini',
              style: TextStyle(
                color: VColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return postItem(
                context,
                index: index,
                id: data[index].id!,
                imageUrl: data[index].thumbnailUrl!,
                title: data[index].title!,
                description: data[index].description!,
                category: data[index].category!.name!,
                createdAt: data[index].createdAtDiff!,
                stack: 1,
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  AppBar _appBar(CategoryController categoryController, {required Category category}) {
    return AppBar(
      title: Skeletonizer(
        enabled: categoryController.isLoading.value,
        child: Text(
          category.name ?? 'Kategori',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: VColors.primary,
          ),
        ),
      ),
      titleSpacing: 0,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }
}