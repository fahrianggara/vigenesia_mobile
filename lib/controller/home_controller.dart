import 'dart:convert';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class HomeController extends GetxController 
{
  var categories = <Category>[].obs;
  var carouselPosts = <Post>[].obs;
  var posts = <Post>[].obs;
  var isLoading = false.obs;

  // define refresh
  late RefreshController refreshController;

  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  // Getter for refresh controller
  void onRefresh() async {
    try {
      await getCarouselPosts();
      await getCategories();
      await getPosts();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  // loading
  void onLoading() async {
    refreshController.loadComplete();
  }

  // get the posts item
  getPosts() async {
    isLoading.value = true;

    try {
      var response = await ApiService.api(
        endpoint: postsURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      // masukkan ke dalam model carouselPosts
      List<dynamic> data = jsonDecode(response.body)['data'];
      posts.value = data.map((json) => Post.fromJson(json)).toList();

      isLoading.value = false;
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    }
  }

  // Get the posts carousel
  getCarouselPosts() async {
    isLoading.value = true;

    try {
      var response = await ApiService.api(
        endpoint: postsCarouselURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      // masukkan ke dalam model carouselPosts
      List<dynamic> data = jsonDecode(response.body)['data'];
      carouselPosts.value = data.map((json) => Post.fromJson(json)).toList();

      isLoading.value = false;
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    }
  }

  // Get the categories from api
  getCategories() async {
    isLoading.value = true;

    try {
      var response = await ApiService.api(
        endpoint: categoriesURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      // masukkan ke dalam model categories
      List<dynamic> data = jsonDecode(response.body)['data'];
      categories.value = data.map((json) => Category.fromJson(json)).toList();

      isLoading.value = false;
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    }
  }
}