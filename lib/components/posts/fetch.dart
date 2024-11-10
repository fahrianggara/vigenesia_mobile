import 'package:flutter/material.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:vigenesia/utils/helpers.dart';

class Posts extends StatelessWidget {
  Posts({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getPosts();

    return Container(
      child: Obx(() {
        if (homeController.posts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.posts.length,
          itemBuilder: (context, index) {
            return postItem(
              index: index, 
              id: homeController.posts[index].id!, 
              imageUrl: homeController.posts[index].thumbnailUrl!, 
              title: homeController.posts[index].title!, 
              description: homeController.posts[index].description!, 
              category: homeController.posts[index].category!.name!, 
              createdAt: homeController.posts[index].createdAtDiff!
            );
          },
        );
      }),
    );
  }
}
