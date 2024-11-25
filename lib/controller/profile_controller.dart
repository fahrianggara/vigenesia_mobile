import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/model/user.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class ProfileController extends GetxController 
{
  var isLoading = false.obs;
  var user = Rx<User?>(null);
  var posts = <Post>[].obs;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var usernameController = TextEditingController();

  // Set initial value for name and username

  Future<void> onRefresh() async {
    try {
      isLoading.value = true;
      await me();  // Assumed function to fetch user data
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Get me (logined user)
  Future<void> me() async 
  {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: meURL,
        method: ApiMethod.get,
        authenticated: true,
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body)['data'];
        user.value = User.fromJson(userData);
        
        // Assign posts to profileController.posts if available
        posts.assignAll(
          (userData['posts'] as List<dynamic>).map((post) => Post.fromJson(post)).toList()
        );

        // Set initial values for controllers
        nameController.text = userData['name'] ?? '';
        usernameController.text = userData['username'] ?? '';
      } else {
        notify(
          message: Text(jsonDecode(response.body)['message']),
          type: 'danger'
        );
      }
    } catch (e) {
      dd("PROFILE/ME: Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(BuildContext context) async 
  {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: updateProfileURL,
        method: ApiMethod.post,
        authenticated: true,
        body: {
          'name': nameController.text,
          'username': usernameController.text,
        },
      );

      dd("${response.statusCode}: ${response.body}");

      switch (response.statusCode) {
        case 200:
          await me();

          Navigator.pop(context);
          Navigator.pop(context);
          
          showNotification(context, json.decode(response.body)['message'], "info");
          
          break;
        default:
          showNotification(context, json.decode(response.body)['message'], "danger");
          break;
      }
    } catch (e) {
      dd("PROFILE/UPDATE: Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }
}