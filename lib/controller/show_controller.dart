import 'package:get/get.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/model/post.dart';
import 'dart:convert';

class ShowController extends GetxController {
  var isLoading = false.obs;
  var post = Rx<Post?>(null);
  final int? id;

  ShowController({this.id});

  @override
  void onInit() {
    super.onInit();
    if (id != null) {
      getPost(id!);
    }
  }

  // Mendapatkan postingan berdasarkan ID
  Future<dynamic> getPost(int id) async {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: "$postsURL/$id",
        method: ApiMethod.get,
      );

      post.value = Post.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      dd("Error getting post: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
