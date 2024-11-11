import 'dart:convert';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class HomeController extends GetxController {
  var categories = <Category>[].obs;
  var carouselPosts = <Post>[].obs;
  var posts = <Post>[].obs;
  var isLoading = false.obs;

  // Define refresh
  late RefreshController refreshController;

  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();

    // Set loading before fetching categories
    isLoading.value = true;
    await getCategories(); // Load categories once when controller is initialized
    isLoading.value = false;
  }

  // Refresh controller
  void onRefresh() async {
    try {
      isLoading.value = true;  // Set loading state
      await getCarouselPosts();
      await getCategories();
      await getPosts();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    } finally {
      isLoading.value = false;  // Reset loading state after refresh
    }
  }

  // Loading
  void onLoading() async {
    refreshController.loadComplete();
  }

  // Get posts item
  Future<void> getPosts() async {
    try {
      var response = await ApiService.api(
        endpoint: postsURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      // Map response to posts model
      List<dynamic> data = jsonDecode(response.body)['data'];
      posts.value = data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Get posts for carousel
  Future<void> getCarouselPosts() async {
    try {
      var response = await ApiService.api(
        endpoint: postsCarouselURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      // Map response to carousel posts model
      List<dynamic> data = jsonDecode(response.body)['data'];
      carouselPosts.value = data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Get categories from API
  Future<void> getCategories() async {
    try {
      var response = await ApiService.api(
        endpoint: categoriesURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      // Map response to categories model
      List<dynamic> data = jsonDecode(response.body)['data'];
      categories.value = data.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
