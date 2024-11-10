import 'package:flutter/material.dart';
import 'package:vigenesia/components/navigation.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [
        HomeRoute(),
        SearchRoute(),
        ProfileRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return SafeArea(
          child: Scaffold(
            appBar: appBar(),
            body: child,  // Ensure you're using 'child' here to display the selected tab
            bottomNavigationBar: bottomNavigationBar(tabsRouter),
          ),
        );
      },
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: VColors.white,
      elevation: 0,
      title: Text(
        appName,
        style: TextStyle(
          color: VColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

