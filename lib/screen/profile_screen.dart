import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/profile/posts.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/controller/profile_controller.dart';
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
                return profileContainer(showTitle);
              },
            ),
            CupertinoSliverRefreshControl(
              onRefresh: profileController.onRefresh,
            ),
            profileContent(),
          ],
        ),
      ),
    );
  }

  Widget profileContainer(showTitle) {
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
  }

  Widget profileContent() 
  {
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
          Obx(() {
            return profileController.posts.isNotEmpty
              ? Posts()
              : emptyPosts(
                sub: "Hei ${profileController.user.value?.name}, Postingan kamu gaada nih? Ayo buat, gratis ini kok."
              );
          }),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // User profile widget
  Widget userProfile(ProfileController profileController) {
    return userInfo(profileController, avatarRadius: 30, isInAppBar: false);
  }

  // User profile for the app bar
  Widget userInAppBar(ProfileController profileController) {
    return userInfo(profileController, avatarRadius: 20, isInAppBar: true);
  }
}