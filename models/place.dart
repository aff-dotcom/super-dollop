// lib/models/place.dart
import 'package:fripesfinderv2/models/review.dart';

class Place {
  final String id;
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final String userId;
  final List<String> photos;
  final List<String> tags;
  final double rating;
  final List<Review> reviews;
  final int likes;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.photos,
    required this.tags,
    required this.rating,
    required this.reviews,
    this.likes = 0, // Ajout du paramètre likes avec une valeur par défaut
  });
}
