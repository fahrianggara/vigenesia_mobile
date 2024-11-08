import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/category.dart';
import 'package:vigenesia/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/utils/constant.dart';
import 'dart:convert';

class HomeController extends GetxController {
  // Define variables with Rx type for reactivity
  var posts = <Post>[].obs; // Observable list for posts
  var carouselPosts = <Post>[].obs; // Observable list for carousel posts
  var categories = <Category>[].obs; // Observable list for categories
  var isLoading = false.obs; // Loading state

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // Getter for refresh controller
  void onRefresh() async {
    // await Future.delayed(Duration(milliseconds: 1000));
    await getPostsCarousel();
    await getPosts();
    await fetchCategories();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // await Future.delayed(Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

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
      debugPrint("Carousel Posts: ${carouselPosts.length} items loaded"); // Memastikan data ada
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
      debugPrint("Posts: ${posts.length} items loaded"); // Memastikan data ada
    } catch (e) {
      apiRes.message = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Get categories
  fetchCategories() async {
    isLoading.value = true;
    ApiResponse apiRes = ApiResponse();

    try {
      final response = await http.get(
        Uri.parse(categoriesURL),
        headers: {'Accept': 'application/json'},
      );
      apiRes.statusCode = response.statusCode;

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      List<dynamic> data = jsonDecode(response.body)['data'];
      categories.value = data.map((json) => Category.fromJson(json)).toList();
      apiRes.message = jsonDecode(response.body)['message'];
      debugPrint("Categories: ${categories.length} items loaded"); // Memastikan data ada
    } catch (e) {
      apiRes.message = e.toString();
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
