import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/utils/constant.dart';
import 'package:vigenesia/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vigenesia/models/user.dart';

/// This function is used to login user
///  - [username] is the username of the user
/// - [password] is the password of the user
/// - It returns an [ApiResponse] object
/// 
Future<ApiResponse> login(String username, String password) async {
  ApiResponse apiRes = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(loginURL), 
      headers: {'Accept': 'application/json'}, 
      body: {
        'username': username,
        'password': password,
      }
    );

    apiRes.statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
        apiRes.data = User.fromJson(jsonDecode(response.body)['data']);
        apiRes.message = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiRes.message = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiRes.message = jsonDecode(response.body)['message'] ?? response.reasonPhrase;
        break;
    }
  } catch (e) {
    // jika sedang offline
    if (e.toString().contains('SocketException')) {
      apiRes.message = "Tidak ada koneksi internet";
    } else {
      apiRes.message = somethingWentWrong;
    }
  }

  debugPrint(apiRes.toString());

  return apiRes;
}


/// This function is used to register user
/// - [email] is the email of the user
/// - [password] is the password of the user
/// - [passwordConfirm] is the confirmation of the password
/// - It returns an [ApiResponse] object
Future<ApiResponse> register(
  String name, 
  String username, 
  String email, 
  String password, 
  String passwordConfirm
) async {
  ApiResponse apiRes = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(registerURL), 
      headers: {'Accept': 'application/json'}, 
      body: {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirm,
      }
    );

    apiRes.statusCode = response.statusCode;

    switch (response.statusCode) {
      case 201:
        apiRes.data = User.fromJson(jsonDecode(response.body)['data']);
        apiRes.message = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiRes.message = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiRes.message = jsonDecode(response.body)['message'] ?? response.reasonPhrase;
        break;
    }
  } catch (e) {
    // jika sedang offline
    if (e.toString().contains('SocketException')) {
      apiRes.message = "Tidak ada koneksi internet";
    } else {
      apiRes.message = somethingWentWrong;
    }
  }

  debugPrint(apiRes.toString());

  return apiRes;
}

/// This function to get user details
/// - It returns an [ApiResponse] object
Future<ApiResponse> getUser() async {
  ApiResponse apiRes = ApiResponse();
  final token = await getToken();

  try {
    final response = await http.get(Uri.parse(meURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    apiRes.statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
        apiRes.data = User.fromJson(jsonDecode(response.body)['data']);
        break;
      default:
        apiRes.message = jsonDecode(response.body)['message'] ?? response.reasonPhrase;
        break;
    }
  } catch (e) {
    // jika sedang offline
    if (e.toString().contains('SocketException')) {
      apiRes.message = "Tidak ada koneksi internet";
    } else {
      apiRes.message = somethingWentWrong;
    }
  }

  return apiRes;
}

/// This function is to get the token from the shared preferences
Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

/// This function is to get user id
Future<int> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id') ?? 0;
}

/// This function is to Logout user
Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('user_id');
}

