// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:vigenesia/screen/home_screen.dart' as _i1;
import 'package:vigenesia/screen/login_screen.dart' as _i2;
import 'package:vigenesia/screen/main_screen.dart' as _i3;
import 'package:vigenesia/screen/postadd_screen.dart' as _i4;
import 'package:vigenesia/screen/profile_screen.dart' as _i5;
import 'package:vigenesia/screen/register_screen.dart' as _i6;
import 'package:vigenesia/screen/search_screen.dart' as _i7;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i9.Key? key,
    String? flashMessage,
    String? flashType,
    List<_i8.PageRouteInfo>? children,
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

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i2.LoginScreen(
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

  final _i9.Key? key;

  final String? flashMessage;

  final String? flashType;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, flashMessage: $flashMessage, flashType: $flashType}';
  }
}

/// generated route for
/// [_i3.MainScreen]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainScreen();
    },
  );
}

/// generated route for
/// [_i4.PostaddScreen]
class PostaddRoute extends _i8.PageRouteInfo<void> {
  const PostaddRoute({List<_i8.PageRouteInfo>? children})
      : super(
          PostaddRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostaddRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.PostaddScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.RegisterScreen]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute({List<_i8.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i7.SearchScreen]
class SearchRoute extends _i8.PageRouteInfo<void> {
  const SearchRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SearchScreen();
    },
  );
}
