import 'dart:convert';
import 'package:get/get.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class SearchController extends GetxController 
{
  var isLoading = false.obs;
  var posts = <Post>[].obs; // Daftar postingan
  var searchResults = <Post>[].obs; // Hasil pencarian postingan
  var notFound = false.obs;
  var hasQuery = false.obs;

  Future<void> search(String query) async {
    isLoading.value = true;
    notFound.value = true;
    hasQuery.value = true;

    try {
      final response = await ApiService.api(
        endpoint: postsURL,
        method: ApiMethod.get,
        parameters: "?q=$query",
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to search posts: ${json.decode(response.body)['message']}');
      }

      if (query.isEmpty) {
        searchResults.clear();
        hasQuery.value = false;
        notFound.value = false;
        dd("Masuk ke query kosong");
      } else {
        final data = json.decode(response.body)['data'] as List;
        searchResults.assignAll(data.map((e) => Post.fromJson(e)).toList());
        hasQuery.value = false;
        notFound.value = false;
        dd ("Masuk ke true data");
      }

    } catch (e) {
      dd("Error searching posts: $e");
      if (e.toString().contains('Data Postingan Kosong!')) {
        notFound.value = true;
        hasQuery.value = false; 
        dd("Masuk ke exception");
      }
    } finally {
      isLoading.value = false;
      hasQuery.value = false;
    }
  }
}