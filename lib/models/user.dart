import 'package:vigenesia/models/post.dart';

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
  List<Post>? posts; // Ubah ke List<Post> jika `posts` adalah daftar

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

  // Factory method to create a new User instance from a map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
      role: json['role'],
      lastLogin: json['last_login'],
      createdAt: json['created_at'],
      token: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      posts: json['posts'] != null 
          ? List<Post>.from(json['posts'].map((x) => Post.fromJson(x))) 
          : null,
    );
  }
}
