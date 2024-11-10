import 'package:auto_route/auto_route.dart';
import 'app_route.gr.dart';

@AutoRouterConfig()
class AppRoute extends RootStackRouter  {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page, 
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ]
    ),

    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: PostCreateRoute.page)
  ];
}