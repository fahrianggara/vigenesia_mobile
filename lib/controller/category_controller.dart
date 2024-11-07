import 'dart:convert';

import 'package:vigenesia/models/category.dart';
import 'package:flutter/material.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/utils/constant.dart';

Future<ApiResponse> fetch() async {
  ApiResponse apiRes = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse(categoriesURL),
      headers: {'Accept': 'application/json'},
    );
    apiRes.statusCode = response.statusCode;

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['message']);
    }

    // Asumsikan `data` berisi daftar kategori dalam JSON respons
    List<dynamic> data = jsonDecode(response.body)['data'];
    apiRes.data = data.map((json) => Category.fromJson(json)).toList();
    apiRes.message = jsonDecode(response.body)['message'];
  } catch (e) {
    apiRes.message = e.toString();
  }

  return apiRes;
}
