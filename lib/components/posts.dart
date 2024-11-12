import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
// Import profile controller
import 'widget.dart';

class Posts extends StatelessWidget {
  // Accept a controller as a parameter
  final dynamic controller;

  // Constructor
  const Posts({
    super.key, 
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure getPosts is called for the dynamic controller
    controller.getPosts();

    return Container(
      child: Obx(() {
        // Check if posts are empty and show a loading skeleton while waiting for data
        if (controller.isLoading.value) {
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
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return postItem(
              index: index,
              id: controller.posts[index].id!,
              imageUrl: controller.posts[index].thumbnailUrl!,
              title: controller.posts[index].title!,
              description: controller.posts[index].description!,
              category: controller.posts[index].category!.name!,
              createdAt: controller.posts[index].createdAtDiff!,
            );
          },
        );
      }),
    );
  }
}
