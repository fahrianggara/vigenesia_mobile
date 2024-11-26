import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/components/profile/posts.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/theme/theme_provider.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vigenesia/components/bottom_sheet.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());
  final ScrollController _scrollController = ScrollController();

  bool showTitle = false;

  @override
  void initState() {
    super.initState();

    authController.onInit(); // Ensure onInit is called
    profileController.onInit();
    profileController.me();

    _scrollController.addListener(() {
      final shouldShowTitle = _scrollController.offset > 90;

      // Update only when the value changes
      if (showTitle != shouldShowTitle) {
        setState(() {
          showTitle = shouldShowTitle;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn.value) { // Jika login
        return profileAuth(context);
      } else { // Jika tidak login
        return profileNoAuth(context);
      }
    });
  }

  Widget profileAuth(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            profileContainer(),
            CupertinoSliverRefreshControl(
              onRefresh: profileController.onRefresh,
            ),
            profileContent(),
          ],
        ),
      ),
    );
  }

  Widget profileContainer() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: userProfile(profileController),
        ),
      ),
      title: showTitle ? userInAppBar(profileController) : null,
      backgroundColor: VColors.primary,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.white, size: 26),
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return profileSettings(context, profileController);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget profileContent() {
    Text text = const Text(''); // Nilai default
    double height = 40;

    if (profileController.posts.isNotEmpty || profileController.isLoading.value) {
      text = Text(
        'Postingan Kamu (${profileController.posts.length})',
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
            padding: const EdgeInsets.only(
              left: 20, 
              top: 18, 
              right: 20, 
              bottom: 10
            ),
            child: Skeletonizer(
              enabled: profileController.isLoading.value,
              child: text,
            ),
          ),
          SizedBox(height: height),
          Obx(() {
            return profileController.posts.isNotEmpty || profileController.isLoading.value
                ? Posts()
                : emptyPosts(
                  sub: "Hei ${profileController.user.value?.name}, Postingan kamu gaada nih? Ayo buat, gratis ini kok.");
          }),
          const SizedBox(height: 20),
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

  // Profile settings
  Widget profileSettings(BuildContext context, ProfileController profileController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(19),
          topRight: Radius.circular(19),
        ),
        color: Theme.of(context).colorScheme.surface
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildListTile(
            context,
            icon: Icons.camera_alt,
            title: 'Edit Foto Profile',
            textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            onTap: () {
              photoProfileBottomSheet(context, profileController, title: 'Edit Foto Profile');
            },
          ),
          const SizedBox(height: 3),
          buildListTile(
            context,
            icon: Icons.person,
            title: 'Edit Profile',
            textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            onTap: () {
              editProfileBottomSheet(context, profileController, title: 'Edit Profile');
            },
          ),
          const SizedBox(height: 3),
          buildListTile(
            context,
            icon: Icons.lock,
            title: 'Edit Password',
            textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            onTap: () {
              editPasswordBottomSheet(context, profileController, title: 'Edit Password');
            },
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          const SizedBox(height: 13),
          buildListTile(
            context,
            icon: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                ? Icons.light_mode
                : Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.contrast, // Ikon untuk tema sistem
            textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            title: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                ? 'Tema Terang'
                : Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                    ? 'Tema Gelap'
                    : 'Tema Sistem', // Teks untuk tema sistem
            onTap: () {
              themeBottomSheet(context);
            },
            borderRadius: BorderRadius.circular(15),
          ),
          const SizedBox(height: 13),
          buildListTile(
            context,
            icon: Icons.logout,
            title: 'Keluar',
            onTap: () {
              Navigator.pop(context);
              authController.logout(context);
            },
            tileColor: Theme.of(context).colorScheme.errorContainer,
            iconColor: Colors.red,
            textStyle: const TextStyle(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
    );
  }

}
