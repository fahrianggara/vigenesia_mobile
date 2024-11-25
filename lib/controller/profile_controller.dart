// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/model/user.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class ProfileController extends GetxController 
{
  var isLoading = false.obs;
  var isLoadingForm = false.obs;
  var user = Rx<User?>(null);
  var posts = <Post>[].obs;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(),
    usernameController = TextEditingController(),
    passwordController = TextEditingController(),
    newPasswordController = TextEditingController(),
    confirmPasswordController = TextEditingController();

  // Error fields for server-side validation
  final nameError = RxString(''),
    usernameError = RxString(''),
    passwordError = RxString(''),
    newPasswordError = RxString(''),
    confirmPasswordError = RxString('');

  // Reset function
  void resetForm() {
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    nameError.value = '';
    usernameError.value = '';
    passwordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  Future<void> onRefresh() async {
    try {
      isLoading.value = true;
      await me();  // Assumed function to fetch user data
    } catch (e) {
      dd("Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Get me (logined user)
  Future<void> me() async 
  {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: meURL,
        method: ApiMethod.get,
        authenticated: true,
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body)['data'];
        user.value = User.fromJson(userData);
        
        // Assign posts to profileController.posts if available
        posts.assignAll(
          (userData['posts'] as List<dynamic>).map((post) => Post.fromJson(post)).toList()
        );

        // Set initial values for controllers
        nameController.text = userData['name'] ?? '';
        usernameController.text = userData['username'] ?? '';
      } else {
        notify(
          message: Text(jsonDecode(response.body)['message']),
          type: 'danger'
        );
      }
    } catch (e) {
      dd("PROFILE/ME: Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(BuildContext context) async 
  {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: updateProfileURL,
        method: ApiMethod.post,
        authenticated: true,
        body: {
          'name': nameController.text,
          'username': usernameController.text,
        },
      );

      switch (response.statusCode) {
        case 200:
          Navigator.pop(context);
          Navigator.pop(context);

          showNotification(context, json.decode(response.body)['message'], "info");

          // Reset error fields
          nameError.value = '';
          usernameError.value = '';

          break;
        case 400:
          Navigator.pop(context);
          Navigator.pop(context);

          showNotification(context, json.decode(response.body)['message'], "info");
        case 422:
          var errors = json.decode(response.body)['errors'];

          nameError.value = errors['name'] != null ? errors['name'][0] : '';
          usernameError.value = errors['username'] != null ? errors['username'][0] : '';

          break;
        default:
          showNotification(context, json.decode(response.body)['message'], "danger");
          break;
      }
    } catch (e) {
      dd("PROFILE/UPDATE: Terjadi Kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePassword(BuildContext context) async {
    isLoadingForm.value = true;

    try {
      final response = await ApiService.api(
        endpoint: updateProfileURL,
        method: ApiMethod.post,
        authenticated: true,
        body: {
          'password': passwordController.text,
          'new_password': newPasswordController.text,
          'password_confirmation': confirmPasswordController.text,
        },
      );

      switch (response.statusCode) {
        case 200:
          Navigator.pop(context);
          Navigator.pop(context);

          showNotification(context, json.decode(response.body)['message'], "info");

          // Reset form fields
          resetForm();

          break;
        case 400:
          Navigator.pop(context);
          Navigator.pop(context);

          showNotification(context, json.decode(response.body)['message'], "info");
        case 422:
          var errors = json.decode(response.body)['errors'];

          passwordError.value = errors['password'] != null ? errors['password'][0] : '';
          newPasswordError.value = errors['new_password'] != null ? errors['new_password'][0] : '';
          confirmPasswordError.value = errors['password_confirmation'] != null ? errors['password_confirmation'][0] : '';

          break;
        default:
          showNotification(context, json.decode(response.body)['message'], "danger");
          break;
      }
    } catch (e) {
      dd("PROFILE/UPDATE: Terjadi Kesalahan: $e");
    } finally {
      isLoadingForm.value = false;
    }
  }
}