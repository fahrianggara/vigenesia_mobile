import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class AuthController extends GetxController
{
  var isLoggedIn = false.obs;
  var isLoading = false.obs;

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

      isLoading.value = false;

      switch (response.statusCode) {
        case 201: // sudah dibuat
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
        case 422: // Validasi
            final errors = jsonDecode(response.body)['errors'];
            notify(
              context: context,
              message: Text("${errors[errors.keys.elementAt(0)][0]}"),
              type: 'danger',
            );
          break;
        default:
          notify(
            context: context,
            message: const Text("An unexpected error occurred."),
            type: 'danger',
          );
          break;
      }
    } catch (e) {
      notify(
        context: context,
        message: Text("Error: $e"),
        type: 'danger',
      );
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