import 'package:vigenesia/model/post.dart';

class User {
  int? id;
  String? username;
  String? name;
  String? email;
  String? photoUrl;
  String? role;
  String? lastLogin;
  String? createdAt;
  String? token;
  String? tokenType;
  List<Post>? posts;

  User({
    this.id,
    this.username,
    this.name,
    this.email,
    this.photoUrl,
    this.role,
    this.lastLogin,
    this.createdAt,
    this.token,
    this.tokenType,
    this.posts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'], // Handling possible String to int conversion
      username: json['username'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
      role: json['role'],
      lastLogin: json['last_login'],
      createdAt: json['created_at'],
      token: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      posts: json['posts'] != null && json['posts'] is List
        ? List<Post>.from(json['posts'].map((x) => Post.fromJson(x))) 
        : null,
    );
  }
}
