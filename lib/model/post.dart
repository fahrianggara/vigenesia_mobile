import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/model/user.dart';

class Post {
  int? id;
  String? title;
  String? slug;
  String? thumbnailUrl;
  String? content;
  String? description;
  String? status;
  String? userId;
  String? categoryId;
  String? createdAt;
  String? createdAtDiff;
  User? user;
  Category? category;

  Post({
    this.id,
    this.title,
    this.slug,
    this.thumbnailUrl,
    this.content,
    this.description,
    this.status,
    this.userId,
    this.categoryId,
    this.createdAt,
    this.createdAtDiff,
    this.user,
    this.category,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      thumbnailUrl: json['thumbnail_url'],
      content: json['content'],
      description: json['description'],
      status: json['status'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      createdAtDiff: json['create_at_diff'],
      user: User.fromJson(json['user']),
      category: Category.fromJson(json['category']),
    );
  }
}