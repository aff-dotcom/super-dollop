import 'package:flutter/material.dart';
import '../models/outfit.dart';

class OutfitCard extends StatelessWidget {
  final Outfit outfit;

  const OutfitCard({super.key, required this.outfit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(outfit.photos.first),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(outfit.description),
          ),
          Wrap(
            spacing: 8,
            children: outfit.hashtags.map((tag) => Chip(label: Text(tag))).toList(),
          ),
        ],
      ),
    );
  }
}
