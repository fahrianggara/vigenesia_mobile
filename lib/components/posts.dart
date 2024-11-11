import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:vigenesia/controller/profile_controller.dart'; // Import profile controller
import 'package:vigenesia/utils/utilities.dart';
import 'widget.dart';

class Posts extends StatelessWidget {
  // Accept a controller as a parameter
  final dynamic controller;
  final String? emptyTitle;
  final String? emptySub;

  // Constructor
  Posts({
    super.key, 
    required this.controller, 
    this.emptyTitle = 'Postingan Kosong??', 
    this.emptySub = 'Postingan kamu belum ada nih? Ayo buat, gratis ini kok!'
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
        } else if (controller.posts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.vectorEmpty,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 30),
                  Text(
                    emptyTitle ?? '',
                    style: TextStyle(fontSize: 18, color: VColors.primary, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    emptySub ?? '',
                    style: TextStyle(fontSize: 16, color: VColors.gray),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
