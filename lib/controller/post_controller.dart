// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:image_cropper/image_cropper.dart'; // New import for cropping

class PostController extends GetxController 
{
  var isLoading = false.obs;
  var post = Rx<Post?>(null);
  var categories = <Category>[].obs;
  var selectCategory = Rx<Category?>(null);
  var thumbnail = Rxn<File>();
  var formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find();
  final HomeController homeController = Get.find();
  final ProfileController profileController = Get.find();

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> onRefresh() async {
    isLoading.value = true;
    try {
      selectCategory.value = null;
      thumbnail.value = null;
      formKey.currentState!.reset();
    } catch (e) {
      dd("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Select the category option
  void setSelectedCategory(Category? category) {
    selectCategory.value = category;
  }

  // Fetch the categories
  Future<void> getCategories() async 
  {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: fetchCategoryURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load categories: ${json.decode(response.body)['message']}');
      }

      final data = json.decode(response.body)['data'] as List;
      categories.assignAll(data.map((e) => Category.fromJson(e)).toList());

      isLoading.value = false;
    } catch (e) {
      dd("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Create post
  Future<void> create(
    BuildContext context, {
    TextEditingController? titleController,
    TextEditingController? contentController,
  }) async {
    isLoading.value = true;

    try {
      // Periksa apakah kategori sudah dipilih
      if (selectCategory.value == null) {
        throw Exception('Silakan pilih kategori postingan');
      }

      // Prepare the body data for the API request
      final body = {
        'title': titleController!.text,
        'content': contentController!.text,
        'category_id': selectCategory.value!.id,
        'status': 'published',
      };

      // If a thumbnail is provided, add it to the body
      if (thumbnail.value != null && thumbnail.value is File) {
        body['thumbnail'] = thumbnail.value;
      }

      // Panggil API dengan Multipart jika ada thumbnail
      final response = await ApiService.api(
        endpoint: storePostURL,
        method: ApiMethod.post,
        authenticated: true,
        body: body,
      );

      // Tangani respons berdasarkan status kode
      switch (response.statusCode) {
        case 201:
          showNotification(context, json.decode(response.body)['message'], "info");
          clearForm();

          // return to the previous screen
          context.maybePop();

          // Segarkan daftar postingan
          await homeController.getPosts();
          await homeController.getCategories();
          await homeController.getCarouselPosts();
          await profileController.me();
          await profileController.getPosts();
          break;
        case 422:
          final errors = json.decode(response.body)['errors'];
          var message = errors[errors.keys.elementAt(0)][0];
          showNotification(context, "$message", 'danger');
          break;
        default:
          var message = json.decode(response.body)['message'];
          showNotification(context, "$message", 'danger');
          break;
      }
    } catch (e) {
      dd("Error: $e");
      showNotification(context, "$e", 'danger');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to pick and crop image
  Future<void> pickAndCropImage() async {
    final ImagePicker picker = ImagePicker();

    // Step 1: Pick an image
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Step 2: Crop the image
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Pangkas Gambar',
            toolbarColor: VColors.primary,
            activeControlsWidgetColor: VColors.primary,
            toolbarWidgetColor: VColors.white,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true,
            hideBottomControls: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: 'Pangkas Gambar',
          ),
        ],
      );

      // Step 3: Update the imageFile if cropping was successful
      if (croppedFile != null) {
        thumbnail.value = File(croppedFile.path);
      }
    }
  }

  void clearForm() {
    thumbnail.value = null;
    selectCategory.value = null;
    formKey.currentState!.reset();
  }
}