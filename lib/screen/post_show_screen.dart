import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/controller/show_controller.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/widget.dart';

@RoutePage()
class PostShowScreen extends StatelessWidget {
  final int? id;
  const PostShowScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final ShowController showController = Get.put(ShowController());

    // Ensure id is not null before fetching the post
    if (id != null) {
      showController.getPost(id!); // Get post by id
    }

    return Obx(() {
      final post = showController.post.value;
      
      // Handle case when post is still null or loading
      if (post == null || showController.isLoading.value) {
        return postIsNull();
      }

      return Scaffold(
        appBar: _appBar(context, showController),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics( // Adds bounce effect when scrolling
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
      );
    });
  }

  AppBar _appBar(BuildContext context, ShowController showController) 
  {
    final post = showController.post.value;
    
    if (post == null) {
      return AppBar();
    }

    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.white,
      title: Skeletonizer(
        enabled: showController.isLoading.value,
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
              mainAxisSize: MainAxisSize.min,  // Ensures the Column only takes the needed space
              children: [
                Text(
                  post.user!.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 15,
                    color: VColors.primary,
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
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            dd('More button pressed');
          },
        ),
      ],
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
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .7
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  post.content!,
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: .5,
                    color: VColors.gray,
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
            context.router.push(CategoryShowRoute(id: post.category!.id));
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
            color: HexColor('#000000').withOpacity(0.5),
          ),
        ),
        Text(
          post.createdAtDiff!,
          style: TextStyle(
            fontSize: 14,
            color: VColors.gray,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        )
      ],
    );
  }
}
