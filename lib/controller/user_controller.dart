import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/utils/constant.dart';

class UserController extends GetxController 
{
  var isLoading = false.obs; // Observable for loading state
  var apiResponse = ApiResponse().obs; // Observable to hold API response
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await getToken();
    isLoggedIn.value = token.isNotEmpty;
  }

  // Modify the login method in the controller to return the API response
  Future<ApiResponse> login(String username, String password) async {
    isLoading.value = true;
    ApiResponse apiResponse = ApiResponse();
    
    try {
      final response = await http.post(
        Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'username': username, 'password': password},
      );

      apiResponse.statusCode = response.statusCode;

      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.body)['data']);
          apiResponse.message = jsonDecode(response.body)['message'];
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.message = errors[errors.keys.elementAt(0)][0];
          break;
        default:
          apiResponse.message = jsonDecode(response.body)['message'] ?? response.reasonPhrase;
          break;
      }
    } catch (e) {
      apiResponse.message = e.toString().contains('SocketException') 
          ? "Tidak ada koneksi internet"
          : somethingWentWrong;
    } finally {
      isLoading.value = false;
      debugPrint(apiResponse.toString());
    }

    return apiResponse;
  }

  Future<ApiResponse> register(
    String name, 
    String username, 
    String email,
    String password, 
    String passwordConfirm
  ) async {
    
    isLoading.value = true;
    ApiResponse response = ApiResponse();  // Local variable for API response
    try {
      final res = await http.post(
        Uri.parse(registerURL),
        headers: {'Accept': 'application/json'},
        body: {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirm,
        },
      );

      response.statusCode = res.statusCode;

      switch (res.statusCode) {
        case 201:
          response.data = User.fromJson(jsonDecode(res.body)['data']);
          response.message = jsonDecode(res.body)['message'];
          break;
        case 422:
          final errors = jsonDecode(res.body)['errors'];
          response.message = errors[errors.keys.elementAt(0)][0];
          break;
        default:
          response.message = jsonDecode(res.body)['message'] ?? res.reasonPhrase;
          break;
      }
    } catch (e) {
      response.message = e.toString().contains('SocketException')
          ? "Tidak ada koneksi internet"
          : somethingWentWrong;
    } finally {
      isLoading.value = false;
      debugPrint(response.toString());
    }

    return response; // Return ApiResponse directly, not Rx<ApiResponse>
  }

  /// Function to get token from shared preferences
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  /// Function to get user ID from shared preferences
  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0;
  }
}
