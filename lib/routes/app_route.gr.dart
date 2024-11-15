// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:vigenesia/screen/category_show_screen.dart' as _i1;
import 'package:vigenesia/screen/home_screen.dart' as _i2;
import 'package:vigenesia/screen/login_screen.dart' as _i3;
import 'package:vigenesia/screen/main_screen.dart' as _i4;
import 'package:vigenesia/screen/post_add_screen.dart' as _i5;
import 'package:vigenesia/screen/post_show_screen.dart' as _i6;
import 'package:vigenesia/screen/profile_screen.dart' as _i7;
import 'package:vigenesia/screen/register_screen.dart' as _i8;
import 'package:vigenesia/screen/search_screen.dart' as _i9;

/// generated route for
/// [_i1.CategoryShowScreen]
class CategoryShowRoute extends _i10.PageRouteInfo<CategoryShowRouteArgs> {
  CategoryShowRoute({
    _i11.Key? key,
    int? id,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CategoryShowRoute.name,
          args: CategoryShowRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryShowRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryShowRouteArgs>(
          orElse: () => const CategoryShowRouteArgs());
      return _i1.CategoryShowScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class CategoryShowRouteArgs {
  const CategoryShowRouteArgs({
    this.key,
    this.id,
  });

  final _i11.Key? key;

  final int? id;

  @override
  String toString() {
    return 'CategoryShowRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i11.Key? key,
    String? flashMessage,
    String? flashType,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            flashMessage: flashMessage,
            flashType: flashType,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i3.LoginScreen(
        key: args.key,
        flashMessage: args.flashMessage,
        flashType: args.flashType,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.flashMessage,
    this.flashType,
  });

  final _i11.Key? key;

  final String? flashMessage;

  final String? flashType;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, flashMessage: $flashMessage, flashType: $flashType}';
  }
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.PostAddScreen]
class PostAddRoute extends _i10.PageRouteInfo<void> {
  const PostAddRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PostAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostAddRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.PostAddScreen();
    },
  );
}

/// generated route for
/// [_i6.PostShowScreen]
class PostShowRoute extends _i10.PageRouteInfo<PostShowRouteArgs> {
  PostShowRoute({
    _i11.Key? key,
    int? id,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PostShowRoute.name,
          args: PostShowRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'PostShowRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostShowRouteArgs>(
          orElse: () => const PostShowRouteArgs());
      return _i6.PostShowScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class PostShowRouteArgs {
  const PostShowRouteArgs({
    this.key,
    this.id,
  });

  final _i11.Key? key;

  final int? id;

  @override
  String toString() {
    return 'PostShowRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i8.RegisterScreen]
class RegisterRoute extends _i10.PageRouteInfo<void> {
  const RegisterRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i9.SearchScreen]
class SearchRoute extends _i10.PageRouteInfo<void> {
  const SearchRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SearchScreen();
    },
  );
}
