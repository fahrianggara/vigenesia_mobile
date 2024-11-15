import 'package:get/get.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/model/post.dart';
import 'dart:convert';

class ShowController extends GetxController 
{
  var isLoading = false.obs;
  var post = Rx<Post?>(null);

  // Mendapatkan postingan berdasarkan ID
  Future<void> getPost(int id) async 
  {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: "$postsURL/$id",
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load post: ${json.decode(response.body)['message']}');
      }

      post.value = Post.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      dd("Error getting post: $e");
    } finally {
      isLoading.value = false;
    }
  }
}