import 'package:vigenesia/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widget.dart';

class Posts extends StatelessWidget {
  Posts({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value || profileController.posts.isEmpty) {
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
        itemCount: profileController.posts.length,
        itemBuilder: (context, index) {
          return postItem(
            context,
            index: index,
            id: profileController.posts[index].id!,
            imageUrl: profileController.posts[index].thumbnailUrl!,
            title: profileController.posts[index].title!,
            description: profileController.posts[index].description!,
            category: profileController.posts[index].category!.name!,
            createdAt: profileController.posts[index].createdAtDiff!,
          );
        },
      );
    });
  }
}
