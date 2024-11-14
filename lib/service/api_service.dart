import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/utils/utilities.dart';

enum ApiMethod { get, post, put, delete }

class ApiService 
{
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
      int? authId = session.getInt('authId');
      dd("Token: $token, AuthId: $authId");

      // Tambahkan token ke dalam header
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    // Buat URL dari endpoint dan parameter
    final url = Uri.parse(endpoint + parameters);

    try {
      // Buat request berdasarkan method
      var request = http.MultipartRequest(method.name.toUpperCase(), url);

      // Tambahkan header ke dalam request
      request.headers.addAll(headers);

      // Tambahkan field body ke dalam request
      body.forEach((key, value) async 
      {
        // Jika value adalah file, tambahkan sebagai multipart
        if (value is File) {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        } else { // Jika value adalah string, tambahkan sebagai field biasa
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
