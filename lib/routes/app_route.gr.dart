// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:vigenesia/model/post.dart' as _i13;
import 'package:vigenesia/screen/category_show_screen.dart' as _i1;
import 'package:vigenesia/screen/home_screen.dart' as _i2;
import 'package:vigenesia/screen/login_screen.dart' as _i3;
import 'package:vigenesia/screen/main_screen.dart' as _i4;
import 'package:vigenesia/screen/post_add_screen.dart' as _i5;
import 'package:vigenesia/screen/post_edit_screen.dart' as _i6;
import 'package:vigenesia/screen/post_show_screen.dart' as _i7;
import 'package:vigenesia/screen/profile_screen.dart' as _i8;
import 'package:vigenesia/screen/register_screen.dart' as _i9;
import 'package:vigenesia/screen/search_screen.dart' as _i10;

/// generated route for
/// [_i1.CategoryShowScreen]
class CategoryShowRoute extends _i11.PageRouteInfo<CategoryShowRouteArgs> {
  CategoryShowRoute({
    _i12.Key? key,
    int? id,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          CategoryShowRoute.name,
          args: CategoryShowRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryShowRoute';

  static _i11.PageInfo page = _i11.PageInfo(
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

  final _i12.Key? key;

  final int? id;

  @override
  String toString() {
    return 'CategoryShowRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.PostAddScreen]
class PostAddRoute extends _i11.PageRouteInfo<void> {
  const PostAddRoute({List<_i11.PageRouteInfo>? children})
      : super(
          PostAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostAddRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.PostAddScreen();
    },
  );
}

/// generated route for
/// [_i6.PostEditScreen]
class PostEditRoute extends _i11.PageRouteInfo<PostEditRouteArgs> {
  PostEditRoute({
    required _i13.Post post,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          PostEditRoute.name,
          args: PostEditRouteArgs(
            post: post,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PostEditRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostEditRouteArgs>();
      return _i6.PostEditScreen(
        post: args.post,
        key: args.key,
      );
    },
  );
}

class PostEditRouteArgs {
  const PostEditRouteArgs({
    required this.post,
    this.key,
  });

  final _i13.Post post;

  final _i12.Key? key;

  @override
  String toString() {
    return 'PostEditRouteArgs{post: $post, key: $key}';
  }
}

/// generated route for
/// [_i7.PostShowScreen]
class PostShowRoute extends _i11.PageRouteInfo<PostShowRouteArgs> {
  PostShowRoute({
    _i12.Key? key,
    int? id,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          PostShowRoute.name,
          args: PostShowRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'PostShowRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostShowRouteArgs>(
          orElse: () => const PostShowRouteArgs());
      return _i7.PostShowScreen(
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

  final _i12.Key? key;

  final int? id;

  @override
  String toString() {
    return 'PostShowRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i9.RegisterScreen]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i10.SearchScreen]
class SearchRoute extends _i11.PageRouteInfo<void> {
  const SearchRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.SearchScreen();
    },
  );
}
