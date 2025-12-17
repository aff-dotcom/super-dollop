// lib/models/outfit.dart
class Comment {
  final String text;
  final String userName;

  Comment({required this.text, required this.userName});
}

class Outfit {
  final String id;
  final String description;
  final List<String> photos;
  final List<String> hashtags;
  final DateTime createdAt;
  final String userId;
  final int likes;
  final List<Comment> comments; // Ajoute ce champ

  Outfit({
    required this.id,
    required this.description,
    required this.photos,
    required this.hashtags,
    required this.createdAt,
    required this.userId,
    this.likes = 0,
    this.comments = const [], // Valeur par défaut : liste vide
  });
}
