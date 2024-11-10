import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/utils/utilities.dart';

enum ApiMethod { get, post, put, delete }

class ApiService 
{
  static var client = http.Client();

  static Future<dynamic> api({
    required String endpoint,
    required ApiMethod type,
    var body = const {},
    bool authenticated = true,
    String parameters = ""
  }) async {
    // Preferences
    SharedPreferences session = await SharedPreferences.getInstance();

    // Set headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    // Add authentication token if required
    if (authenticated) {
      String? token = session.getString('token');
      debugPrint("Token kamu: $token");

      // jika ada set ke header
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    // Construct URL with parameters if any
    final url = Uri.parse(endpoint + parameters);

    http.Response res;
    try {
      // Handle different HTTP methods
      switch (type) {
        case ApiMethod.get:
          res = await client.get(url, headers: headers);
          break;
        case ApiMethod.post:
          res = await client.post(url, headers: headers, body: jsonEncode(body));
          break;
        case ApiMethod.put:
          res = await client.put(url, headers: headers, body: jsonEncode(body));
          break;
        case ApiMethod.delete:
          res = await client.delete(url, headers: headers);
          break;
        default:
          throw Exception("Invalid HTTP method");
      }

      // Handle response status (200,201,204)
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(res.body);
      } else {
        // Handle errors or unsuccessful ress
        throw Exception("Error: ${res.statusCode}, ${res.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("API Error: $e");
      throw Exception("Network error or invalid response");
    }
  }
}
