import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/posts.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/components/widget.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> 
{
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    authController.onInit();  // Ensure onInit is called
    profileController.onInit();
    profileController.me();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn.value) { // Jika login
        return profileAuth(context);
      } else { // jika engga loggin
        return profileNoAuth(context);
      }
    });
  }

  // Screen for logged-in users
  Widget profileAuth(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                          image: AssetImage(Images.background),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: userProfile(profileController),
                    ),
                  ),
                  title: showTitle ? userInAppBar(profileController) : null,
                  backgroundColor: VColors.primary,
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
                    Visibility(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          icon: Icon(Icons.logout, color: Colors.white, size: 26),
                          onPressed: () {
                            authController.logout(context);
                          },
                        ),
                      ),
                    ),
                  ]
                );
              },
            ),
            CupertinoSliverRefreshControl(
              onRefresh: profileController.onRefresh,
            ),
            profileContent()
          ],
        ),
      ),
    );
  }

  Widget profileContent() {
    Text text = Text('');  // Nilai default
    double height = 40;

    if (profileController.posts.isNotEmpty) {
      text = Text(
        'Postingan Kamu',
        style: TextStyle(
          color: VColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );

      height = 0;
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 18, right: 20, bottom: 10),
            child: text,
          ),
          SizedBox(height: height),
          Posts(
            controller: profileController,
            emptySub: "Hei ${profileController.user.value?.name}, Postingan kamu gaada nih? Ayo buat, gratis ini kok.",
          )
        ],
      ),
    );
  }

  Widget userProfile(ProfileController profileController) {
    return Obx(() {
      final user = profileController.user.value;
      final isLoading = user == null; // Treat as loading if `user` is null

      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar Skeleton
          Skeletonizer(
            enabled: isLoading,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user?.photoUrl ?? 'https://via.placeholder.com/150'),
            ),
          ),
          const SizedBox(width: 18),
          
          // User Info Skeleton
          Skeletonizer(
            enabled: isLoading,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'User Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@${user?.username ?? 'username'}',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget userInAppBar(ProfileController profileController) {
    return Obx(() {
      final user = profileController.user.value;
      final isLoading = user == null; // Treat as loading if `user` is null

      return Row(
        children: [
          // Avatar Skeleton
          Skeletonizer(
            enabled: isLoading,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                user?.photoUrl ?? 'https://via.placeholder.com/150',
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Name Skeleton
          Skeletonizer(
            enabled: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? 'User Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
