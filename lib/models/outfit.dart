// lib/models/outfit.dart
class Outfit {
  final String id;
  final String description;
  final List<String> photos;
  final List<String> hashtags;
  final DateTime createdAt;
  final String userId;
  final int likes;

  Outfit({
    required this.id,
    required this.description,
    required this.photos,
    required this.hashtags,
    required this.createdAt,
    required this.userId,
    this.likes = 0,
  });
}
