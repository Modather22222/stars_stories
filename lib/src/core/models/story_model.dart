class StoryModel {
  final int id;
  final String title;
  final String category;
  final String coverUrl;
  final List<StoryPage> pages;
  final DateTime createdAt;

  StoryModel({
    required this.id,
    required this.title,
    required this.category,
    required this.coverUrl,
    required this.pages,
    required this.createdAt,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      coverUrl: json['cover_url'] as String,
      pages: (json['content'] as List<dynamic>)
          .map((e) => StoryPage.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'cover_url': coverUrl,
      'content': pages.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class StoryPage {
  final String imageUrl;
  final String text;

  StoryPage({
    required this.imageUrl,
    required this.text,
  });

  factory StoryPage.fromJson(Map<String, dynamic> json) {
    return StoryPage(
      imageUrl: json['image_url'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'text': text,
    };
  }
}
