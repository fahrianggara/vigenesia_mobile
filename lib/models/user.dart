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
      token: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}
