import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'bottom_sheet.dart';
import 'package:vigenesia/screen/profile_photo_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/components/posts_user_show.dart';

Future<dynamic> userShowBottomSheet(
  BuildContext context,
  int userId,
  UserController userController
) {
  userController.fetchUser(userId);

  return modalBottomSheet(context, useRootNavigator: true, (builder) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: appBar(
          context, 
          title: "Detail Pengguna", 
          titleColor: Theme.of(context).colorScheme.onSurface,
          leading: IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Obx(() {
                  var user = userController.user.value;

                  if (user == null || userController.isLoading.value) {
                    return loadWidgetUser(userController);
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfilePhotoScreen(user: user),
                            ),
                          );
                        },
                        child: Skeletonizer(
                          enabled: userController.isLoading.value,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, bottom: 20),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(user.photoUrl ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, bottom: 27),
                          child: Skeletonizer(
                            enabled: userController.isLoading.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  user.name ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  user.username ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Obx(() {
                return profileContent(userController);
              }),
            ],
          ),
        ),
      ),
    );
  });
}

Widget profileContent(UserController userController) {
  Text text = const Text(''); // Nilai default
  double height = 40;

  if (userController.posts.isNotEmpty || userController.isLoading.value) {
    text = Text(
      'Ada ${userController.posts.length} Postingan',
      style: TextStyle(
        color: VColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );

    height = 0;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Obx(() {
        return userController.user.value != null
          ? Padding(
              padding: const EdgeInsets.only(
                left: 20, 
                top: 18, 
                right: 20, 
                bottom: 10
              ),
              child: Skeletonizer(
                enabled: userController.isLoading.value,
                child: text,
              ),
            )
          : const SizedBox();
      }),
      SizedBox(height: height),
      Obx(() {
        return userController.posts.isNotEmpty || userController.isLoading.value 
          ? PostsUserShow()
          : emptyPosts(sub: "Postingan ${userController.user.value?.name} masih kosong.");
      }),
      const SizedBox(height: 20),
    ],
  );
}

Widget loadWidgetUser(UserController userController) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Skeletonizer(
        enabled: true,
        child: Container(
          margin: EdgeInsets.only(left: 20, bottom: 20),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(Images.background2),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 20, bottom: 27),
          child: Skeletonizer(
            enabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Nama Pengguna',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Username Pengguna',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    ],
  );
}