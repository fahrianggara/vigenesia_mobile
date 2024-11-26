import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/navigation.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    authController.checkLoginStatus();

    return AutoTabsRouter.pageView(
      routes: const [
        HomeRoute(),
        SearchRoute(),
        ProfileRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: _appBar(tabsRouter, context),
          body: child,  // Ensure you're using 'child' here to display the selected tab
          bottomNavigationBar: bottomNavigationBar(tabsRouter, context),
          floatingActionButton: Obx(() => 
            // Show addButton only if logged in and not on SearchRoute tab
            authController.isLoggedIn.value && tabsRouter.activeIndex != 1
              ? addButton(context)
              : SizedBox.shrink(), // Hide the button when on SearchRoute tab
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(TabsRouter tabsRouter, BuildContext context) {
    final title = tabsRouter.activeIndex == 0
      ? appName
      : tabsRouter.activeIndex == 1
        ? 'Pencarian'
        : 'Profile';
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      automaticallyImplyLeading: tabsRouter.activeIndex != 2,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: VColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  FloatingActionButton addButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.navigateTo(const PostAddRoute()); // Assuming you have an AddPostRoute
      },
      backgroundColor: VColors.primary, // You can customize the color
      foregroundColor: VColors.white,
      child: Icon(Icons.add),
    );
  }
}
