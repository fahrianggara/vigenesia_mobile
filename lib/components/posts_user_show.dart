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
          return postItem(
            context,
            index: index,
            id: userController.posts[index].id!,
            imageUrl: userController.posts[index].thumbnailUrl!,
            title: userController.posts[index].title!,
            description: userController.posts[index].description!,
            category: userController.posts[index].category!.name!,
            createdAt: userController.posts[index].createdAtDiff!,
          );
        },
      );
    });
  }
}
