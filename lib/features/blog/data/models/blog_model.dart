import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.updatedAt,
    required super.postedId,
    required super.imageUrl,
    required super.title,
    required super.content,
    required super.topics,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'posted_id': postedId,
      'image_url': imageUrl,
      'title': title,
      'content': content,
      'topics': topics,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map["updated_at"]),
      postedId: map['posted_id'] as String,
      imageUrl: map['image_url'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      topics: List<String>.from(map['topics'] ?? []),
    );
  }

  BlogModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? postedId,
    String? imageUrl,
    String? title,
    String? content,
    List<String>? topics,
  }) {
    return BlogModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      postedId: postedId ?? this.postedId,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
    );
  }
}
