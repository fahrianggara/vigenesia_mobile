import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum ApiMethod { get, post, put, delete }

class ApiService 
{
  static var client = http.Client();

  static Future<dynamic> api({
    required String endpoint,
    required ApiMethod method,
    var body = const {},
    bool authenticated = false,
    String parameters = ""
  }) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (authenticated) {
      String? token = session.getString('token');
      debugPrint("Token kamu: $token");
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    final url = Uri.parse(endpoint + parameters);

    http.Response response;
    try {
      switch (method) {
        case ApiMethod.get:
          response = await client.get(url, headers: headers);
          break;
        case ApiMethod.post:
          response = await client.post(url, headers: headers, body: jsonEncode(body));
          break;
        case ApiMethod.put:
          response = await client.put(url, headers: headers, body: jsonEncode(body));
          break;
        case ApiMethod.delete:
          response = await client.delete(url, headers: headers);
          break;
        default:
          throw Exception("Invalid HTTP method");
      }

      return response;
    } catch (e) {
      debugPrint("API Error: $e");
      throw Exception("Network error or invalid response");
    }
  }
}
