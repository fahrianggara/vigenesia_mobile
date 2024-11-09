import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart'; // New import for cropping
import 'package:vigenesia/models/api_response.dart';
import 'package:vigenesia/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/utils/constant.dart';

class PostController extends GetxController {
  var categories = <Category>[].obs;
  var selectedCategory = Rx<Category?>(null);
  var imageFile = Rxn<File>();  // To store the selected and cropped image

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    ApiResponse apiRes = ApiResponse();

    try {
      final response = await http.get(
        Uri.parse(fetchCategoryURL),
        headers: {'Accept': 'application/json'},
      );

      apiRes.statusCode = response.statusCode;

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      List<dynamic> data = jsonDecode(response.body)['data'];
      categories.value = data.map((json) => Category.fromJson(json)).toList();
      apiRes.message = jsonDecode(response.body)['message'];

      debugPrint("Categories: ${categories.length} items loaded");
    } catch (e) {
      apiRes.message = e.toString();
      debugPrint(e.toString());
    }
  }

  void setSelectedCategory(Category? category) {
    selectedCategory.value = category;
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
            toolbarColor: AppColors.primary,
            activeControlsWidgetColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
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
        imageFile.value = File(croppedFile.path);
      }
    }
  }

}
