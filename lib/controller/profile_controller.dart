import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/model/user.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class ProfileController extends GetxController 
{
  var isLoading = false.obs;
  var user = Rx<User?>(null);
  var posts = <Post>[].obs;

  Future<void> onRefresh() async {
    try {
      isLoading.value = true;
      await me();  // Assumed function to fetch user data
      await getPosts();
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

      switch (response.statusCode) {
        case 200:
          user.value = User.fromJson(jsonDecode(response.body)['data']);
          break;
        default:
          notify(
            message: Text(jsonDecode(response.body)['message']),
            type: 'danger'
          );
      }
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPosts() async 
  {
    try {
      var response = await ApiService.api(
        endpoint: meURL,
        method: ApiMethod.get,
        authenticated: true
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      // Map response to posts model
      List<dynamic> data = jsonDecode(response.body)['data']['posts'];
      posts.value = data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }
}