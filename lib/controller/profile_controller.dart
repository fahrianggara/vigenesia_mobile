import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/utils/constant.dart';

class ProfileController extends GetxController 
{
  var user = Rx<User?>(null);
  var isLoggedIn = false.obs;
  var isLoading = false.obs; // Observable for loading state
  var apiResponse = ApiResponse().obs;

  late RefreshController refreshController;


  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
  }

  // Getter for refresh controller
  void onRefresh() async {
    try {
      await _getUser();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  void onLoading() async {
    // await Future.delayed(Duration(milliseconds: 1000));
    await _getUser();
    refreshController.loadComplete();
  }

  Future<ApiResponse> _getUser() async {
    isLoading.value = true;
    
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse(meURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      apiResponse.value.statusCode = response.statusCode;

      if (apiResponse.value.statusCode == 200) {
        // Parsing data user dari JSON response
        final userData = jsonDecode(response.body)['data'];
        user.value = User.fromJson(userData); // Update user data
        debugPrint("User data loaded: ${user.value.toString()}");
        apiResponse.value.message = jsonDecode(response.body)['message'];
      } else {
        // Mengambil pesan error jika ada atau menggunakan reasonPhrase
        apiResponse.value.message = jsonDecode(response.body)['message'] ?? response.reasonPhrase;
      }
    } catch (e) {
      apiResponse.value.message = e.toString().contains('SocketException') 
          ? "Tidak ada koneksi internet" 
          : somethingWentWrong;
    } finally {
      isLoading.value = false;
    }

    return apiResponse.value;
  }

  /// Function to get token from shared preferences
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  /// Function to log out the user
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id');

    // Reset state to reflect logout
    user.value = null;
    isLoggedIn.value = false;
    apiResponse.value = ApiResponse(); // Clear API response data
    update(); // Trigger update on all observers
    
    // Navigate to login screen or main screen after logout
    Get.offAllNamed('/'); 
  }
}