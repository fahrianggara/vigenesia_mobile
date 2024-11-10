import 'dart:convert';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController
{
  var isLoggedIn = false.obs;
  var isLoading = false.obs;

  // Get the token from session
  Future<String> getToken() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    return session.getString('token') ?? '';
  }
}