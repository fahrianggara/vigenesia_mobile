import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final ScrollController _scrollController = ScrollController();
  final ProfileController profileController = Get.put(ProfileController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProfileController>(
          init: profileController,
          builder: (controller) => SmartRefresher(
            controller: profileController.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: Obx(() {
              // Check loading state
              if (profileController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  AnimatedBuilder(
                    animation: _scrollController,
                    builder: (context, child) {
                      bool showTitle = _scrollController.offset > 100;
                      return SliverAppBar(
                        expandedHeight: 160,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/search.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: userProfile(profileController),
                          ),
                        ),
                        title: showTitle ? userInAppBar(profileController) : null,
                        backgroundColor: AppColors.primary,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: IconButton(
                              icon: Icon(Icons.settings, color: Colors.white, size: 26),
                              onPressed: () {
                                print('Settings button pressed');
                              },
                            ),
                          ),
                          Obx(() => Visibility(
                                visible: userController.isLoggedIn.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: IconButton(
                                    icon: Icon(Icons.logout, color: Colors.white, size: 26),
                                    onPressed: () {
                                      profileController.logout();
                                    },
                                  ),
                                ),
                              )),
                        ],
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Postingan Anda',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget userProfile(ProfileController profileController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            profileController.user.value?.photoUrl ?? 'https://via.placeholder.com/150',
          ),
        ),
        const SizedBox(width: 18),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileController.user.value?.name ?? 'Loading...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@${profileController.user.value?.username ?? ''}',
                style: TextStyle(
                  color: AppColors.primary100,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget userInAppBar(ProfileController profileController) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            profileController.user.value?.photoUrl ?? 'https://via.placeholder.com/150',
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              profileController.user.value?.name ?? 'Loading...',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),
            ),
          ],
        ),
      ],
    );
  }
}
