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

    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/register', page: RegisterRoute.page),
    AutoRoute(path: '/posts/create', page: PostaddRoute.page),
    AutoRoute(path: '/posts/show/:id', page: PostshowRoute.page),
  ];
}