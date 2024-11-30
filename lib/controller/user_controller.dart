import 'dart:convert';

import 'package:get/get.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/model/user.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class UserController extends GetxController {
  var isLoading = false.obs; // Untuk menampilkan indikator loading
  var user = Rx<User?>(null); // Data pengguna
  var posts = <Post>[].obs; // Daftar postingan pengguna

  Future<void> fetchUser(int userId) async {
    try {
      isLoading.value = true;
      await getUser(userId);
    } catch (e) {
      dd("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUser(int id) async {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: "$userURL/$id",
        method: ApiMethod.get,
      );

      switch (response.statusCode) {
        case 200:
          var userData = jsonDecode(response.body)['data'];
          user.value = User.fromJson(userData);

          if (userData['posts'] != null) {
            posts.assignAll(
              List<Post>.from(userData['posts'].map((x) => Post.fromJson(x))),
            );
          }
          break;
        default:
          dd("Error getting user: ${jsonDecode(response.body)['message']}");
          break;
      }
    } catch (e) {
      dd("Error getting user: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
