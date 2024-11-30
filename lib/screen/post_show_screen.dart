import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/components/user_show.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/controller/post_controller.dart';
import 'package:vigenesia/controller/show_controller.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/screen/post_edit_screen.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

@RoutePage()
class PostShowScreen extends StatelessWidget {
  final int? id;
  final String? stack;

  const PostShowScreen({super.key, this.id, this.stack});

  @override
  Widget build(BuildContext context) {
    // Hapus instance lama (jika ada) sebelum membuat controller baru
    if (Get.isRegistered<ShowController>()) {
      Get.delete<ShowController>();
    }

    // Inisialisasi controller dengan ID
    final ShowController showController = Get.put(ShowController(id: id));
    final AuthController authController = Get.put(AuthController());
    final PostController postController = Get.put(PostController());
    final UserController userController = Get.put(UserController());
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Obx(() {
      final post = showController.post.value;

      // Tampilkan skeleton jika data masih loading
      if (post == null || showController.isLoading.value) {
        return postIsNull();
      }

      // Bungkus Scaffold dalam ModalProgressHUD
      return ModalProgressHUD(
        inAsyncCall: postController.isLoading.value,
        color: Theme.of(context).colorScheme.surface,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(
          color: VColors.primary,
        ),
        child: Scaffold(
          key: scaffoldKey,
          appBar: _appBar(context, showController, authController, postController, userController, scaffoldKey),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeletonizer(
                  enabled: showController.isLoading.value,
                  child: postContent(post, context),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar _appBar(
    BuildContext context,
    ShowController showController,
    AuthController authController,
    PostController postController,
    UserController userController,
    scaffoldKey,
  ) {
    final post = showController.post.value;

    if (post == null) {
      return AppBar();
    }

    // Tambahkan flag
    bool isDeletePressed = false;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          AutoRouter.of(context).popUntil((route) => route.isFirst);
        },
      ),
      titleSpacing: 0,
      scrolledUnderElevation: 0,
      title: Skeletonizer(
        enabled: showController.isLoading.value,
        child: InkWell(
          onTap: () {
            if (stack == "1") {
              userShowBottomSheet(
                context, 
                int.tryParse(post.userId!) ?? 0, 
                userController
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 19,
                backgroundImage: NetworkImage(
                  post.user!.photoUrl ?? 'https://picsum.photos/seed/$id/200/200',
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    post.user!.name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: stack == "1" ? VColors.primary : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    post.user!.username!,
                    style: TextStyle(fontSize: 12, color: VColors.border500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        FutureBuilder<int>(
          future: authController.getAuthId(), // Panggil fungsi async
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink(); // Placeholder saat menunggu
            }
            if (snapshot.hasError) {
              return const Text("Error loading auth ID"); // Tampilkan error jika ada
            }
            int authId = snapshot.data ?? 0; // Ambil authId dari snapshot
            return Visibility(
              visible: authId == post.user!.id, // Bandingkan authId dengan post.user!.id
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  isDeletePressed = false; // Reset flag sebelum modal dibuka
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return listModalMenu(
                        context,
                        postController,
                        scaffoldKey,
                        post: post,
                        onDelete: () {
                          isDeletePressed = true; // Set flag ketika tombol hapus ditekan
                          Navigator.of(context, rootNavigator: true).pop(); // Tutup modal
                        },
                      );
                    },
                  ).whenComplete(() {
                    // Tampilkan dialog hanya jika flag isDeletePressed true
                    if (isDeletePressed) {
                      showAlertDialog(
                        context, // Kembali ke konteks awal
                        title: 'Hapus Postingan',
                        message: 'Apakah Anda yakin ingin menghapus postingan ini?',
                        onConfirm: () {
                          postController.delete(context, post.id);
                        },
                      );
                    }
                  });
                },
              ),
            );
          },
        )
      ],
    );
  }

  Widget listModalMenu(
    BuildContext context,
    PostController postController,
    scaffoldKey, {
    Post? post,
    VoidCallback? onDelete, // Tambahkan callback
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            tileColor: VColors.gray.withOpacity(0.1),
            iconColor: VColors.warning,
            leading: const Icon(Icons.edit),
            title: const Text('Edit Postingan'),
            onTap: () {
              // Tutup modal tanpa aksi tambahan
              Navigator.of(context, rootNavigator: true).pop();

              // Navigasi ke halaman edit
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostEditScreen(post: post!)));
            },
          ),
          const SizedBox(height: 5),
          ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            tileColor: VColors.gray.withOpacity(0.1),
            iconColor: VColors.danger,
            leading: const Icon(Icons.delete),
            title: const Text('Hapus Postingan'),
            onTap: () {
              if (onDelete != null) {
                onDelete(); // Panggil callback onDelete
              }
            },
          ),
        ],
      ),
    );
  }


  Widget postContent(Post post, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Image.network(
            post.thumbnailUrl ?? 'https://picsum.photos/seed/$id/600/300',
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                postInfo(post, context),
                const SizedBox(height: 15),
                Text(
                  post.title!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .7,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  post.content!,
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: .5,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget postInfo(Post post, BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            AutoRouter.of(context);
            context.router.popAndPush(CategoryShowRoute(id: post.category!.id));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              post.category!.name!,
              style: TextStyle(
                color: VColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          '  •  ',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        Text(
          post.createdAtDiff!,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}