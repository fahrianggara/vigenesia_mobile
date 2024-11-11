import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'widget.dart';

class Posts extends StatelessWidget {
  Posts({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getPosts();

    return Container(
      child: Obx(() {
        // Check if posts are empty and show a loading skeleton while waiting for data
        if (homeController.posts.isEmpty || homeController.isLoading.value) {
          return Skeletonizer(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // Display 5 dummy items when loading
              itemBuilder: (context, index) {
                return postItem(
                  index: index,
                  id: 0, // Placeholder for id
                  imageUrl: '', // Placeholder for image
                  title: 'Loading...', // Placeholder for title
                  description: 'Loading...', // Placeholder for description
                  category: 'Loading...', // Placeholder for category
                  createdAt: 'Loading...', // Placeholder for createdAt
                );
              },
            ),
          );
        }

        // Once posts are loaded, show the actual data
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
              createdAt: homeController.posts[index].createdAtDiff!,
            );
          },
        );
      }),
    );
  }
}
