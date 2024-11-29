import 'package:get/get.dart';
import 'package:vigenesia/model/user.dart';

class UserController extends GetxController {
  Rx<User> user = User().obs;

  void setUser(User newUser) {
    user(newUser);
  }

  // Mendapatkan data user berdasarkan ID
  Future<dynamic> getUser(int id) async {
    // isLoading.value = true;

    try {
      // final response = await ApiService.api(
      //   endpoint: "$user/$id",
      //   method: ApiMethod.get,
      // );
      // user.value = User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      // dd("Error getting user: $e");
    } finally {
      // isLoading.value = false;
    }
  }
}