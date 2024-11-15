import 'package:vigenesia/model/post.dart';

class Category {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? createdAt;
  String? postsCount;
  List<Post>? posts;

  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.createdAt,
    this.postsCount,
    this.posts
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      createdAt: json['created_at'],
      postsCount: json['posts_count'],
      posts: json['posts'] != null 
        ? List<Post>.from(json['posts'].map((x) => Post.fromJson(x))) 
        : null,
    );
  }
}