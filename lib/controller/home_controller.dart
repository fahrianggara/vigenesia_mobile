import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/service/api_service.dart';
import 'package:vigenesia/utils/utilities.dart';

class HomeController extends GetxController 
{
  var categories = <Category>[].obs;
  var isLoading = false.obs;

  // define refresh
  late RefreshController refreshController;

  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  // Getter for refresh controller
  void onRefresh() async {
    try {
      await getCategories();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  void onLoading() async {
    refreshController.loadComplete();
  }

  // Get the categories from api
  getCategories() async {
    isLoading.value = true;

    try {
      var response = await ApiService.api(
        endpoint: categoriesURL,
        method: ApiMethod.get,
      );

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      List<dynamic> data = jsonDecode(response.body)['data'];
      categories.value = data.map((json) => Category.fromJson(json)).toList();

      dd("Kategori berhasil di load dengan total data : ${categories.length}");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}