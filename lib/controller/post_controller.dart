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
import 'package:image_cropper/image_cropper.dart';

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
    try {// Memastikan form di-reset saat refresh
    } catch (e) {
      dd("Error on refresh: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk memilih kategori
  void setSelectedCategory(Category? category) {
    selectCategory.value = category;
  }

  // Mendapatkan daftar kategori
  Future<void> getCategories() async {
    isLoading.value = true;

    try {
      final response = await ApiService.api(
        endpoint: fetchCategoryURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal memuat kategori: ${json.decode(response.body)['message']}');
      }

      final data = json.decode(response.body)['data'] as List;
      categories.assignAll(data.map((e) => Category.fromJson(e)).toList());
    } catch (e) {
      dd("Error getting categories: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Membuat postingan
  Future<void> create(
    BuildContext context, {
    TextEditingController? titleController,
    TextEditingController? contentController,
  }) async {
    isLoading.value = true;

    try {
      // Memeriksa apakah kategori sudah dipilih
      if (selectCategory.value == null) {
        throw Exception('Silakan pilih kategori postingan');
      }

      // Menyiapkan data untuk API
      final body = {
        'title': titleController!.text,
        'content': contentController!.text,
        'category_id': selectCategory.value!.id,
        'status': 'published',
      };

      // Jika thumbnail disediakan, tambahkan ke body
      if (thumbnail.value != null && thumbnail.value is File) {
        body['thumbnail'] = thumbnail.value;
      }

      // Memanggil API
      final response = await ApiService.api(
        endpoint: storePostURL,
        method: ApiMethod.post,
        authenticated: true,
        body: body,
      );

      // Menangani respons
      switch (response.statusCode) {
        case 201:
          // Memperbarui daftar postingan
          await homeController.getPosts();
          await homeController.getCategories();
          await homeController.getCarouselPosts();
          await profileController.me();

           // Kembali ke layar sebelumnya
          context.maybePop(true);

          // Membersihkan form
          selectCategory.value = null;
          thumbnail.value = null;
          formKey.currentState?.reset();

          showNotification(context, json.decode(response.body)['message'], "info");
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
      dd("Error during post creation: $e");
      showNotification(context, "$e", 'danger');
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk memilih dan memotong gambar
  Future<void> pickAndCropImage() async {
    final ImagePicker picker = ImagePicker();

    // Langkah 1: Memilih gambar
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Langkah 2: Memotong gambar
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Pangkas Gambar',
            toolbarColor: VColors.primary,
            activeControlsWidgetColor: VColors.primary,
            toolbarWidgetColor: VColors.white,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true,
            hideBottomControls: false,
            aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
          ),
          IOSUiSettings(title: 'Pangkas Gambar'),
        ],
      );

      // Langkah 3: Memperbarui thumbnail jika pemotongan berhasil
      if (croppedFile != null) {
        thumbnail.value = File(croppedFile.path);
      }
    }
  }
}
