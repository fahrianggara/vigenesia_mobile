import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum ApiMethod { get, post, put, delete }

class ApiService {
  static var client = http.Client();

  static Future<dynamic> api({
    required String endpoint,
    required ApiMethod method,
    var body = const {},
    bool authenticated = false,
    bool multipart = false,
    String parameters = "",
  }) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    // Tambahkan Authorization jika diperlukan
    if (authenticated) {
      String? token = session.getString('token');
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    final url = Uri.parse(endpoint + parameters);

    try {
      var request = http.MultipartRequest(method.name.toUpperCase(), url);
      request.headers.addAll(headers);

      // Tambahkan field body ke dalam request
      body.forEach((key, value) async {
        if (value is File) {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        } else {
          request.fields[key] = value.toString();
        }
      });

      // Kirim request multipart dan tunggu respons
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      debugPrint("API Error: $e");
      throw Exception("Network error or invalid response");
    }
  }
}
