import 'package:flutter/material.dart';
import '../models/place.dart';
import '../utils/constants.dart';

class PlaceDetailsSheet extends StatelessWidget {
  final Place place;
  const PlaceDetailsSheet({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    // Détermine si le lieu est "liké" en vérifiant si le nombre de likes est supérieur à 0
    bool isLiked = place.likes > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(place.name, style: titleStyle),
          Text(place.address, style: subtitleStyle),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(isLiked ? Icons.thumb_up : Icons.thumb_up_outlined, color: Colors.amber),
                onPressed: () {
                  // Logique pour gérer le like/dislike
                },
              ),
              const Spacer(),
              Text('${place.rating}/5'),
            ],
          ),
          // Photos
          if (place.photos.isNotEmpty)
            Image.network(
              place.photos.first,
              height: 150,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 8),
          // Tags
          Wrap(
            spacing: 8,
            children: place.tags.map((tag) => Chip(label: Text(tag))).toList(),
          ),
          const SizedBox(height: 8),
          // Avis
          ...place.reviews.map((review) =>
              ListTile(
                title: Text(review.comment),
                subtitle: Text('Note: ${review.rating}/5'),
              ),
          ),
        ],
      ),
    );
  }
}
