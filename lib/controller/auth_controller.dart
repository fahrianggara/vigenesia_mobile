// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class AuthController extends GetxController 
{
  var isLoggedIn = false.obs;
  var isLoading = false.obs;

  final ProfileController profileController = Get.put(ProfileController());

  Future<void> register(
    BuildContext context,
    TextEditingController name,
    TextEditingController username,
    TextEditingController email,
    TextEditingController password,
    TextEditingController confirm,
  ) async {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: registerURL,
        method: ApiMethod.post,
        body: {
          'name': name.text,
          'username': username.text,
          'email': email.text,
          'password': password.text,
          'password_confirmation': confirm.text
        }
      );

      switch (response.statusCode) {
        case 201:
          context.navigateTo(LoginRoute(
            flashMessage: jsonDecode(response.body)['message'],
            flashType: "info",
          ));

          name.clear();
          username.clear();
          email.clear();
          password.clear();
          confirm.clear();
          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];
          var message = errors[errors.keys.elementAt(0)][0];
          showNotification(context, "$message", 'danger');
          break;

        default:
          showNotification( context, "An unexpected error occurred.", 'danger');
          break;
      }
    } catch (e) {
      showNotification( context, "Error: $e", 'danger');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(
    BuildContext context,
    TextEditingController username,
    TextEditingController password,
  ) async {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: loginURL,
        method: ApiMethod.post,
        body: {
          'username': username.text,
          'password': password.text,
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body)['data'];
          final token = responseBody['access_token'];
          final name = responseBody['name'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          isLoggedIn.value = true;
          context.router.pushAndPopUntil(
            ProfileRoute(), // The route to push
            predicate: (route) => false, // The condition to pop all routes
          );

          username.clear();
          password.clear();

          profileController.me();
          profileController.getPosts();

          showNotification( context, "Selamat datang, $name!", 'info');
          break;

        case 422:
          final errors = jsonDecode(response.body)['errors'];
          showNotification( context, "${errors[errors.keys.elementAt(0)][0]}", 'danger');
          break;

        default:
          showNotification( context, "${jsonDecode(response.body)['message']}", 'danger');
          break;
      }
    } catch (e) {
      showNotification(context, "Error: $e", 'danger');
    } finally {
      isLoading.value = false;
    }
  }

  // In AuthController
  Future<void> logout(BuildContext context) async {
    try {
      // Clear the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      // Mark the user as logged out
      isLoggedIn.value = false;  // This should trigger a rebuild

      // set null
      profileController.user.value = null;
      profileController.posts.value = [];

      update();

      // Optionally show a notification
      showNotification(context, "Kamu berhasil keluar.", 'info');
    } catch (e) {
      // Handle logout failure (optional)
      showNotification(context, "Error logging out: $e", 'danger');
    }
  }

  // Check if the token exists to determine if the user is logged in
  Future<void> checkLoginStatus() async {
    String token = await getToken();
    isLoggedIn.value = token.isNotEmpty;
  }

  // Get the token from session
  Future<String> getToken() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    return session.getString('token') ?? '';
  }
}
