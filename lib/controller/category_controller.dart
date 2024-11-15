import 'package:get/get.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/model/category.dart';
import 'dart:convert';

class CategoryController extends GetxController 
{
  var isLoading = false.obs;
  var category = Rx<Category?>(null);
  var posts = <Post>[].obs;

  // Mendapatkan kategori berdasarkan ID
  Future<void> getCategory(int id) async 
  {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: "$categoriesURL/$id",
        method: ApiMethod.get,
      );

      dd(response.body);

      if (response.statusCode != 200) {
        throw Exception('Failed to load category: ${json.decode(response.body)['message']}');
      }

      var data = json.decode(response.body)['data'];
      category.value = Category.fromJson(data);
      posts.assignAll(
        (data['posts'] as List<dynamic>).map((post) => Post.fromJson(post)).toList()
      );
    } catch (e) {
      dd("Error getting category: $e");
    } finally {
      isLoading.value = false;
    }
  }
}