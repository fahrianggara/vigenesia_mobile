import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/utils/constant.dart';
import 'dart:convert';

class PostController extends GetxController 
{
  // Define variables with Rx type for reactivity
  var posts = <Post>[].obs; // Observable list for posts
  var carouselPosts = <Post>[].obs; // Observable list for carousel posts
  var isLoading = false.obs; // Loading state

  // Method to fetch posts for carousel
  getPostsCarousel() async {
    isLoading.value = true;
    ApiResponse apiRes = ApiResponse();

    try {
      final response = await http.get(
        Uri.parse(postsCarouselURL),
        headers: {'Accept': 'application/json'},
      );

      apiRes.statusCode = response.statusCode;

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      List<dynamic> data = jsonDecode(response.body)['data'];
      carouselPosts.value = data.map((json) => Post.fromJson(json)).toList();
      apiRes.message = jsonDecode(response.body)['message'];
    } catch (e) {
      apiRes.message = e.toString();
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Method to fetch posts
  getPosts() async {
    isLoading.value = true;
    ApiResponse apiRes = ApiResponse();

    try {
      final response = await http.get(
        Uri.parse(postsURL),
        headers: {'Accept': 'application/json'},
      );
      apiRes.statusCode = response.statusCode;

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      List<dynamic> data = jsonDecode(response.body)['data'];
      posts.value = data.map((json) => Post.fromJson(json)).toList();
      apiRes.message = jsonDecode(response.body)['message'];
    } catch (e) {
      apiRes.message = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
