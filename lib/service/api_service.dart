import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
      "Content-Type": "application/json",
    };

    if (authenticated) {
      String? token = session.getString('token');
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    final url = Uri.parse(endpoint + parameters);

    try {
      http.Response response;

      // Gunakan request berbeda berdasarkan method
      if (multipart && method != ApiMethod.get) {
        var request = http.MultipartRequest(method.name.toUpperCase(), url);
        request.headers.addAll(headers);

        body.forEach((key, value) async {
          if (value is File) {
            request.files.add(await http.MultipartFile.fromPath(key, value.path));
          } else {
            request.fields[key] = value.toString();
          }
        });

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        switch (method) {
          case ApiMethod.get:
            response = await http.get(url, headers: headers);
            break;
          case ApiMethod.post:
            response = await http.post(url, headers: headers, body: jsonEncode(body));
            break;
          case ApiMethod.put:
            response = await http.put(url, headers: headers, body: jsonEncode(body));
            break;
          case ApiMethod.delete:
            response = await http.delete(url, headers: headers);
            break;
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("API Error: $e");
      throw Exception("Network error or invalid response");
    }
  }

}
