import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'widget.dart';

class PostsUserShow extends StatelessWidget {

  PostsUserShow({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userController.isLoading.value || userController.posts.isEmpty) {
        // Menampilkan loading skeleton
        return Skeletonizer(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5, // Menampilkan 5 item dummy saat loading
            itemBuilder: (context, index) {
              return postItem(
                context,
                index: index,
                id: 0, // Placeholder untuk id
                imageUrl: '', // Placeholder untuk gambar
                title: 'Loading...', // Placeholder untuk judul
                description: 'Loading...', // Placeholder untuk deskripsi
                category: 'Loading...', // Placeholder untuk kategori
                createdAt: 'Loading...', // Placeholder untuk waktu dibuat
                stack: 0, // Placeholder untuk stack
              );
            },
          ),
        );
      }
    
      // Menampilkan data postingan jika sudah dimuat
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: userController.posts.length,
        itemBuilder: (context, index) {
          var post = userController.posts[index];

          return postItem(
            context,
            index: index,
            id: post.id!,
            imageUrl: post.thumbnailUrl!,
            title: post.title!,
            description: post.description!,
            category: post.category!.name!,
            createdAt: post.createdAtDiff!,
            stack: 0,
          );
        },
      );
    });
  }
}