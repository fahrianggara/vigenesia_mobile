// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
  var photo = Rxn<File>();
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
    photo.value = null;
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
    isLoadingForm.value = true;

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
          resetForm();

          // Refresh user data
          await me();

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
      isLoadingForm.value = false;
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

  Future<void> pickImage(BuildContext context, {required bool isCamera}) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );

      if (pickedFile != null) {
        final CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Pangkas Foto',
              toolbarColor: VColors.primary,
              activeControlsWidgetColor: VColors.primary,
              toolbarWidgetColor: VColors.white,
              initAspectRatio: CropAspectRatioPreset.ratio16x9,
              lockAspectRatio: true,
              hideBottomControls: false,
              aspectRatioPresets: [
                CropAspectRatioPreset.ratio16x9,
                CropAspectRatioPreset.original,
              ],
            ),
            IOSUiSettings(
              title: 'Pangkas Gambar',
            ),
          ],
        );

        if (croppedFile != null) 
        {
          photo.value = File(croppedFile.path);

          isLoading.value = true;

          // Upload photo
          final response = await ApiService.api(
            endpoint: changePhotoURL,
            method: ApiMethod.post,
            authenticated: true,
            multipart: true,
            body: {
              'photo': photo.value,
            },
          );
          
          switch (response.statusCode) {
            case 200:
              // untuk remove modal bottom sheet
              Navigator.pop(context);
              Navigator.pop(context);

              resetForm();

              // Refresh user data
              await me();

              showNotification(context, json.decode(response.body)['message'], "info");
              break;
            default:
              // untuk remove modal bottom sheet
              Navigator.pop(context);
              Navigator.pop(context);
              showNotification(context, json.decode(response.body)['message'], "danger");
              break;
          }

          isLoading.value = false;
        }
      }
    } catch (e) {
      dd("PROFILE/PICK_IMAGE: Terjadi Kesalahan: $e");
    }
  }
}