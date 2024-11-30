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

    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() {
      // Check if posts are empty and show a loading skeleton while waiting for data
      if (homeController.posts.isEmpty || homeController.isLoading.value) {
        return Skeletonizer(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5, // Display 5 dummy items when loading
            itemBuilder: (context, index) {
              return postItem(
                context,
                index: index,
                id: 0, // Placeholder for id
                imageUrl: '', // Placeholder for image
                title: 'Loading...', // Placeholder for title
                description: 'Loading...', // Placeholder for description
                category: 'Loading...', // Placeholder for category
                createdAt: 'Loading...', // Placeholder for createdAt
                stack: 0, // Placeholder for stack
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
          var post = homeController.posts[index];
          
          return postItem(
            context,
            index: index,
            id: post.id!,
            imageUrl: post.thumbnailUrl!,
            title: post.title!,
            description: post.description!,
            category: post.category!.name!,
            createdAt: post.createdAtDiff!,
            stack: 1,
            titleColor: colorScheme.onSurface,
          );
        },
      );
    });
  }
}